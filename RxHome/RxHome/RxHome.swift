
// The MIT License (MIT)
//
// Copyright (c) 2018 Matas Petrikas
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import HomeKit
import RxSwift

public class RxHome: NSObject {
  override init() {
    super.init()
  }
  
  /// The method returns all HomeKit homes of the current user as Rx Observable
  ///
  /// - Returns: an Observable stream of HMHome arrays, subscribe to it to always get the latest home layout of the user
  public func allHomes() -> Observable<[HMHome]> {
    let rxHomeManager = RxHomeManager()
    return rxHomeManager.homes
  }
  
  /// The method returns the primary home of the current user as Rx Observable
  ///
  /// - Returns: an Observable stream of HMHome instances, subscribe to it to always get the current primary home of the user
  public func primaryHome() -> Observable<HMHome> {
    let rxHomeManager = RxHomeManager()
    return rxHomeManager.primaryHome
  }
  
  func allLightbulbs(from home: HMHome? = nil) -> Observable<[HMService]> {
    return services(from: home, serviceType: HMServiceTypeLightbulb)
  }
  
  public func services(from home: HMHome? = nil, serviceType: String) -> Observable<[HMService]> {
    return primaryHome().map({ home in
      guard let services = home.servicesWithTypes([serviceType]) else {
        return []
      }
      return services
    })
  }
  
}

internal class RxHomeManager: NSObject, HMHomeManagerDelegate {
  
  private let homeManager: HMHomeManager
  private let homesStream = PublishSubject<[HMHome]>()
  private let primaryHomeStream = PublishSubject<HMHome>()
  
  var homes: Observable<[HMHome]> {
    return homesStream.asObservable()
  }
  
  var primaryHome: Observable<HMHome> {
    return primaryHomeStream.asObservable()
  }
  
  override init() {
    homeManager = HMHomeManager()
    super.init()
    homeManager.delegate = self
  }

  func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
    homesStream.onNext(manager.homes)
  }
  
  func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
    guard let primaryHome = manager.primaryHome else {
      return
    }
    primaryHomeStream.onNext(primaryHome)
  }
  
  func homeManager(_ manager: HMHomeManager, didAdd home: HMHome) {
    homesStream.onNext(manager.homes)
  }
  
  func homeManager(_ manager: HMHomeManager, didRemove home: HMHome) {
    homesStream.onNext(manager.homes)
  }
}
