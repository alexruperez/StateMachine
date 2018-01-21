//
//  StateMachine.swift
//  StateMachine
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

public class StateMachine {
    
    public typealias SubscriptionIndex = Int
    public typealias SubscribeClosure = (_ previous: State?, _ current: State) -> Void

    public private(set) var current: State?
    private let states: [State]
    private var subscriptions = [SubscribeClosure]()

    public init(_ states: [State]) {
        self.states = states
    }

    public func update(_ deltaTime: TimeInterval) {
        current?.update(deltaTime)
    }

    @discardableResult public func subscribe(_ closure: @escaping SubscribeClosure) -> SubscriptionIndex {
        subscriptions.append(closure)
        return subscriptions.count - 1
    }

    public func unsubscribe(_ index: SubscriptionIndex) -> Bool {
        guard subscriptions.count > index else {
            return false
        }
        _ = subscriptions.remove(at: index)
        return true
    }

    public func canEnterState<S: State>(_ type: S.Type) -> Bool {
        return current == nil || current?.isValidNext(state: type) == true
    }

    @discardableResult public func enter<S: State>(_ type: S.Type) -> Bool {
        guard canEnterState(type), let next = state(type) else {
            return false
        }
        let previous = current
        previous?.willExit(to: next)
        current = next
        subscriptions.forEach { $0(previous, next) }
        next.didEnter(from: previous)
        return true
    }

    public func state<S: State>(_ type: S.Type) -> State? {
        return states.first { $0 is S }
    }
}
