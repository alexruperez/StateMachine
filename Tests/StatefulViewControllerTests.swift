//
//  StatefulViewControllerTests.swift
//  StateMachineTests
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import XCTest
@testable import StateMachine

class StatefulViewControllerTests: XCTestCase {
    
    var statefulViewController: StatefulViewController!

    override func setUp() {
        super.setUp()
        statefulViewController = StatefulViewController()
    }

    override func tearDown() {
        statefulViewController = nil
        super.tearDown()
    }
    
    func testStartWithDisappeared() {
        statefulViewController.viewDidLoad()
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is DisappearedViewControllerState)
    }

    func testWillAppear() {
        statefulViewController.viewWillAppear(false)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is AppearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
        statefulViewController.viewDidAppear(true)
        XCTAssert(statefulViewController.stateMachine.current is AppearedViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
    }

    func testWillAppearAnimated() {
        statefulViewController.viewWillAppear(true)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is AppearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
        statefulViewController.viewWillDisappear(false)
        XCTAssert(statefulViewController.stateMachine.current is DisappearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
    }

    func testDidAppear() {
        statefulViewController.viewDidAppear(false)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is AppearedViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
        statefulViewController.viewWillDisappear(true)
        XCTAssert(statefulViewController.stateMachine.current is DisappearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
    }

    func testDidAppearAnimated() {
        statefulViewController.viewDidAppear(true)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is AppearedViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
        statefulViewController.viewWillDisappear(false)
        XCTAssert(statefulViewController.stateMachine.current is DisappearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
    }

    func testWillDisappear() {
        statefulViewController.viewWillDisappear(false)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is DisappearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
        statefulViewController.viewDidDisappear(true)
        XCTAssert(statefulViewController.stateMachine.current is DisappearedViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
    }

    func testWillDisappearAnimated() {
        statefulViewController.viewWillDisappear(true)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is DisappearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
        statefulViewController.viewWillAppear(false)
        XCTAssert(statefulViewController.stateMachine.current is AppearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
    }

    func testDidDisappear() {
        statefulViewController.viewDidDisappear(false)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is DisappearedViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
        statefulViewController.viewWillAppear(true)
        XCTAssert(statefulViewController.stateMachine.current is AppearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
    }

    func testDidDisappearAnimated() {
        statefulViewController.viewDidDisappear(true)
        XCTAssertNotNil(statefulViewController.stateMachine.current)
        XCTAssert(statefulViewController.stateMachine.current is DisappearedViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, true)
        statefulViewController.viewWillAppear(false)
        XCTAssert(statefulViewController.stateMachine.current is AppearingViewControllerState)
        XCTAssertEqual(statefulViewController.stateMachine.current.animated, false)
    }
    
}
