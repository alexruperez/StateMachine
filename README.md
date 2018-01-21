![StateMachine](https://raw.githubusercontent.com/alexruperez/StateMachine/master/Logo.png)
# StateMachine

[![Twitter](https://img.shields.io/badge/contact-@alexruperez-0FABFF.svg?style=flat)](http://twitter.com/alexruperez)
[![Version](https://img.shields.io/cocoapods/v/ArchitStateMachine.svg?style=flat)](http://cocoapods.org/pods/ArchitStateMachine)
[![License](https://img.shields.io/cocoapods/l/ArchitStateMachine.svg?style=flat)](http://cocoapods.org/pods/ArchitStateMachine)
[![Platform](https://img.shields.io/cocoapods/p/ArchitStateMachine.svg?style=flat)](http://cocoapods.org/pods/ArchitStateMachine)
[![Swift](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)](https://swift.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager Compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![Build Status](https://travis-ci.org/alexruperez/StateMachine.svg?branch=master)](https://travis-ci.org/alexruperez/StateMachine)

Swift library to create [**Finite-state machine**](https://en.wikipedia.org/wiki/Finite-state_machine) inspired by [GKStateMachine](https://developer.apple.com/documentation/gameplaykit/gkstatemachine) from Apple [GameplayKit](https://developer.apple.com/library/content/documentation/General/Conceptual/GameplayKit_Guide/StateMachine.html) framework.

## 🌟 Features

- [x] Define States and Their Behavior.
- [x] Create and Drive a State Machine.
- [x] Subscribe/unsubscribe to State changes.
- [x] UIApplication and UIApplicationDelegate extensions with application life cycle State Machine embedded.
- [x] StatefulViewController subclass with UIViewController life cycle State Machine embedded.

## 📲 Installation

StateMachine is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ArchitStateMachine'
```

#### Or you can install it with [Carthage](https://github.com/Carthage/Carthage):

```ogdl
github "alexruperez/StateMachine"
```

#### Or install it with [Swift Package Manager](https://swift.org/package-manager/):

```swift
dependencies: [
    .package(url: "https://github.com/alexruperez/StateMachine.git")
]
```

## 🐒 Usage

#### Define States and Their Behavior:

```swift
class MyState: State {
    func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        switch type {
        case is OneValidNextState.Type, is OtherValidNextState.Type:
            return true
        default:
            return false
        }
    }
}

class OneValidNextState: State {
    func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        return type is OtherValidNextState.Type
    }

    func didEnter(from previous: State?) {
        // Your code here
    }
}

class OtherValidNextState: State {
    func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        return false
    }

    func willExit(to next: State) {
        // Your code here
    }
}
```

#### Create and Drive a State Machine:

```swift
let stateMachine = StateMachine([MyState(), OneValidNextState(), OtherValidNextState()])

stateMachine.enter(OneValidNextState.self)

stateMachine.enter(OtherValidNextState.self)
```

#### Subscribe/unsubscribe to State changes:

```swift
let subscriptionIndex = stateMachine.subscribe { (previous, current) in
    // Your code here
}

stateMachine.unsubscribe(subscriptionIndex)
```

#### UIApplication and UIApplicationDelegate extensions with application life cycle State Machine embedded:

![UIApplication](https://raw.githubusercontent.com/alexruperez/StateMachine/master/UIApplication.png)

```swift
if UIApplication.shared.stateMachine.current is ActiveApplicationState {
    // Your code here
}
```

#### StatefulViewController subclass with UIViewController life cycle State Machine embedded:

![StatefulViewController](https://raw.githubusercontent.com/alexruperez/StateMachine/master/StatefulViewController.png)

```swift
let viewController = StatefulViewController()

if viewController.stateMachine.current is AppearingViewControllerState {
    // Your code here
}
```

## ❤️ Etc.

* Contributions are very welcome.
* Attribution is appreciated (let's spread the word!), but not mandatory.

## 👨‍💻 Authors

[alexruperez](https://github.com/alexruperez), contact@alexruperez.com

## 👮‍♂️ License

StateMachine is available under the MIT license. See the LICENSE file for more info.