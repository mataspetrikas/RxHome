# RxHome
A lightweight RxSwift library for HomeKit accesories

Note: RxHome is currently still in alpha, it's not advised to use it in production codebase

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
