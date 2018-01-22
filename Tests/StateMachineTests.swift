//
//  StateMachineTests.swift
//  StateMachineTests
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import XCTest
@testable import StateMachine

class StateA: State {
    var deltaTime: TimeInterval = 0

    func update(_ deltaTime: TimeInterval) {
        self.deltaTime = deltaTime
    }

    func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        return type is StateB.Type
    }
}

class StateB: State {
    func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        switch type {
        case is StateA.Type, is StateC.Type:
            return true
        default:
            return false
        }
    }
}

class StateC: State {
    func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        return type is StateA.Type
    }
}

class StateMachineTests: XCTestCase {

    var stateMachine: StateMachine!
    
    override func setUp() {
        super.setUp()
        stateMachine = StateMachine([StateA(), StateB(), StateC()])
    }
    
    override func tearDown() {
        stateMachine = nil
        super.tearDown()
    }
    
    func testStartWithA() {
        XCTAssertNil(stateMachine.current)
        XCTAssert(stateMachine.enter(StateA.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testStartWithB() {
        XCTAssertNil(stateMachine.current)
        XCTAssert(stateMachine.enter(StateB.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateB)
    }

    func testStartWithC() {
        XCTAssertNil(stateMachine.current)
        XCTAssert(stateMachine.enter(StateC.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateC)
    }

    func testAB() {
        XCTAssert(stateMachine.enter(StateA.self))
        XCTAssert(stateMachine.enter(StateB.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateB)
    }

    func testBC() {
        XCTAssert(stateMachine.enter(StateB.self))
        XCTAssert(stateMachine.enter(StateC.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateC)
    }

    func testCA() {
        XCTAssert(stateMachine.enter(StateC.self))
        XCTAssert(stateMachine.enter(StateA.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testABA() {
        XCTAssert(stateMachine.enter(StateA.self))
        XCTAssert(stateMachine.enter(StateB.self))
        XCTAssert(stateMachine.enter(StateA.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testAC() {
        XCTAssert(stateMachine.enter(StateA.self))
        XCTAssertFalse(stateMachine.enter(StateC.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testCB() {
        XCTAssert(stateMachine.enter(StateC.self))
        XCTAssertFalse(stateMachine.enter(StateB.self))
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateC)
    }

    func testUpdate() {
        XCTAssert(stateMachine.enter(StateA.self))
        let deltaTime = TimeInterval(arc4random_uniform(10) + 1)
        stateMachine.update(deltaTime)
        XCTAssertEqual((stateMachine.current as? StateA)?.deltaTime, deltaTime)
        XCTAssert(stateMachine.enter(StateB.self))
        stateMachine.update(deltaTime)
    }

    func testSubscribe() {
        stateMachine.subscribe { (previous, current) in
            XCTAssertNil(previous)
            XCTAssertNotNil(current)
            XCTAssert(current is StateA)
        }
        XCTAssert(stateMachine.enter(StateA.self))
    }

    func testUnsubscribe() {
        let index = stateMachine.subscribe { _, _ in }
        XCTAssert(stateMachine.enter(StateA.self))
        XCTAssert(stateMachine.unsubscribe(index))
        XCTAssertFalse(stateMachine.unsubscribe(index))
    }

    func testUnsubscribeAll() {
        let index = stateMachine.subscribe { _, _ in }
        XCTAssert(stateMachine.enter(StateA.self))
        stateMachine.unsubscribeAll()
        XCTAssertFalse(stateMachine.unsubscribe(index))
    }
    
}
