//
//  ApplicationStateMachineTests.swift
//  StateMachineTests
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import XCTest
@testable import StateMachine

class NotificationCenterMock: NotificationCenterProtocol {
    struct Observer {
        let receiver: AnyObject
        let selector: Selector
        let name: NSNotification.Name?
    }

    var observers = [Observer]()

    func post(name aName: NSNotification.Name, object anObject: Any?) {
        observers.filter { $0.name == aName }.forEach { _ = $0.receiver.perform($0.selector, with: nil) }
    }

    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
        observers.append(Observer(receiver: observer as AnyObject, selector: aSelector, name: aName))
    }

    func removeObserver(_ observer: Any) {
        observers.removeAll()
    }

}

class ApplicationStateMachineTests: XCTestCase {
    
    var stateMachine: ApplicationStateMachine!

    override func setUp() {
        super.setUp()
        stateMachine = ApplicationStateMachine(NotificationCenterMock())
    }

    override func tearDown() {
        stateMachine = nil
        super.tearDown()
    }
    
    func testStartWithNotRunning() {
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is NotRunningApplicationState)
        XCTAssertNil(stateMachine.applicationState)
    }

    func testFinishLaunching() {
        stateMachine.notificationCenter.post(name: .UIApplicationDidFinishLaunching, object: nil)
        XCTAssert(stateMachine.current is InactiveApplicationState)
        XCTAssertEqual(stateMachine.applicationState, .inactive)
    }

    func testBecomeActiveBeforeFinishLaunching() {
        stateMachine.notificationCenter.post(name: .UIApplicationDidBecomeActive, object: nil)
        XCTAssertFalse(stateMachine.current is ActiveApplicationState)
        XCTAssertNil(stateMachine.applicationState)
    }

    func testBecomeActiveAfterFinishLaunching() {
        stateMachine.notificationCenter.post(name: .UIApplicationDidFinishLaunching, object: nil)
        stateMachine.notificationCenter.post(name: .UIApplicationDidBecomeActive, object: nil)
        XCTAssert(stateMachine.current is ActiveApplicationState)
        XCTAssertEqual(stateMachine.current.applicationState, .active)
        stateMachine.notificationCenter.post(name: .UIApplicationWillResignActive, object: nil)
        XCTAssert(stateMachine.current is InactiveApplicationState)
        XCTAssertEqual(stateMachine.applicationState, .inactive)
    }

    func testEnterBackgroundBeforeFinishLaunching() {
        stateMachine.notificationCenter.post(name: .UIApplicationDidEnterBackground, object: nil)
        XCTAssertFalse(stateMachine.current is BackgroundApplicationState)
        XCTAssertNil(stateMachine.applicationState)
    }

    func testEnterBackgroundAfterFinishLaunching() {
        stateMachine.notificationCenter.post(name: .UIApplicationDidFinishLaunching, object: nil)
        stateMachine.notificationCenter.post(name: .UIApplicationDidEnterBackground, object: nil)
        XCTAssert(stateMachine.current is BackgroundApplicationState)
        XCTAssertEqual(stateMachine.applicationState, .background)
    }

    func testResignActive() {
        stateMachine.notificationCenter.post(name: .UIApplicationWillResignActive, object: nil)
        XCTAssert(stateMachine.current is InactiveApplicationState)
        XCTAssertEqual(stateMachine.applicationState, .inactive)
    }

    func testEnterForeground() {
        stateMachine.notificationCenter.post(name: .UIApplicationWillEnterForeground, object: nil)
        XCTAssert(stateMachine.current is InactiveApplicationState)
        XCTAssertEqual(stateMachine.applicationState, .inactive)
    }

    func testTerminateBeforeFinishLaunchingAndEnterBackground() {
        stateMachine.notificationCenter.post(name: .UIApplicationWillTerminate, object: nil)
        XCTAssertFalse(stateMachine.current is SuspendedApplicationState)
        XCTAssertNil(stateMachine.applicationState)
    }

    func testWillTerminateAfterFinishLaunchingAndEnterBackground() {
        stateMachine.notificationCenter.post(name: .UIApplicationDidFinishLaunching, object: nil)
        stateMachine.notificationCenter.post(name: .UIApplicationDidEnterBackground, object: nil)
        stateMachine.notificationCenter.post(name: .UIApplicationWillTerminate, object: nil)
        XCTAssert(stateMachine.current is SuspendedApplicationState)
        XCTAssertNil(stateMachine.applicationState)
    }

    func testApplication() {
        XCTAssertNotNil(UIApplication.shared.stateMachine)
    }
    
}
