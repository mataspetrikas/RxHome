# RxHome
A lightweight RxSwift library for HomeKit accesories

Note: RxHome is currently still in alpha, it's not advised to use it in production codebase

## Installation

### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for CocoaProjects.
To integrate RxBluetoothKit into your Xcode project using CocoaPods specify it in your `Podfile`:
```ruby
pod 'RxHome', :git => 'https://github.com/mataspetrikas/RxHome.git'
```
Then, run following command:
`$ pod install`

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.
To integrate RxHome into your Xcode project using Carthage define it in your `Cartfile`:
```swift
github "mataspetrikas/RxHome"
```
Then, run `carthage update` to build framework and drag `RxHome.framework` into your Xcode project.

## Usage

Make sure you import the library in your code

```swift
import RxHome
```

You can e.g. get the primary home of the user via:


```swift
let homeManager = RxHome()
homeManager
  .primaryHome()
  .subscribe(onNext: { home in
  
      print("Primary home \(home.name) available")
      
   }).disposed(by: disposeBag)
```

You will find more examples in the 'RxHome Example' app code included in the repository.

## License
RxHome is available under the MIT LIcense. See the LICENSE file for more info.
