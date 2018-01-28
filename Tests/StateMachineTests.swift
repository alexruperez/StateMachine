//
//  StateMachineTests.swift
//  StateMachineTests
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import XCTest
@testable import StateMachine

class TestEvent: Event {
    var hashValue: Int {
        return -1
    }
}

class TestState: State {
    var hashValue: Int {
        return -1
    }

    func isValid<E>(next state: TestState, when event: E) -> Bool where E : Event {
        return false
    }
}

class StateA: TestState {
    override var hashValue: Int {
        return 0
    }

    var deltaTime: TimeInterval = 0

    func update(_ deltaTime: TimeInterval) {
        self.deltaTime = deltaTime
    }

    override func isValid<E>(next state: TestState, when event: E) -> Bool where E : Event {
        return state is StateB
    }
}

class StateB: TestState {
    override var hashValue: Int {
        return 1
    }

    override func isValid<E>(next state: TestState, when event: E) -> Bool where E : Event {
        switch state {
        case is StateA, is StateC:
            return true
        default:
            return false
        }
    }
}

class StateC: TestState {
    override var hashValue: Int {
        return 2
    }

    override func isValid<E>(next state: TestState, when event: E) -> Bool where E : Event {
        return state is StateA
    }
}

class StateMachineTests: XCTestCase {

    var stateMachine: StateMachine<TestState, TestEvent>!
    let event = TestEvent()
    
    override func setUp() {
        super.setUp()
        stateMachine = StateMachine<TestState, TestEvent>(initial: StateA())
        let stateA = stateMachine.current
        let stateB = StateB()
        let stateC = StateC()
        stateMachine[stateA] = [event: stateB]
        stateMachine[stateB] = [event: stateC]
        stateMachine[stateC] = [event: stateA]
    }
    
    override func tearDown() {
        stateMachine = nil
        super.tearDown()
    }
    
    func testStartWithA() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testStartWithB() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateB)
    }

    func testStartWithC() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateC)
    }

    func testAB() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateB)
    }

    func testBC() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateC)
    }

    func testCA() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testABA() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testAC() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateA)
    }

    func testCB() {
        XCTAssertNotNil(stateMachine[event])
        XCTAssertNil(stateMachine[event])
        XCTAssertNotNil(stateMachine.current)
        XCTAssert(stateMachine.current is StateC)
    }

    func testUpdate() {
        XCTAssertNotNil(stateMachine[event])
        let deltaTime = TimeInterval(arc4random_uniform(10) + 1)
        stateMachine.update(deltaTime)
        XCTAssertEqual((stateMachine.current as? StateA)?.deltaTime, deltaTime)
        XCTAssertNotNil(stateMachine[event])
        stateMachine.update(deltaTime)
    }

    func testSubscribe() {
        stateMachine.subscribe { (previous, event, current) in
            XCTAssertNil(previous)
            XCTAssertNotNil(current)
            XCTAssert(current is StateA)
        }
        XCTAssertNotNil(stateMachine[event])
    }

    func testUnsubscribe() {
        let index = stateMachine.subscribe { _, _, _ in }
        XCTAssertNotNil(stateMachine[event])
        XCTAssert(stateMachine.unsubscribe(index))
        XCTAssertFalse(stateMachine.unsubscribe(index))
    }

    func testUnsubscribeAll() {
        let index = stateMachine.subscribe { _, _, _ in }
        XCTAssertNotNil(stateMachine[event])
        stateMachine.unsubscribeAll()
        XCTAssertFalse(stateMachine.unsubscribe(index))
    }
    
}
