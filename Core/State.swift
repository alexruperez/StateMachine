//
//  State.swift
//  StateMachine
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Represents a single state in a state machine.
public protocol State: Hashable {
    /// Returns true if the given class is a valid next state to enter.
    /// Implement this method to enforce limited edge traversals in the state machine.
    /// - Parameter type: the class to be checked
    /// - Returns: true if the state transition is valid, else false
    func isValid<E: Event>(next state: Self, when event: E) -> Bool

    /// Called by StateMachine when this state is entered.
    /// - Parameter previous: the state that was exited to enter this state,
    /// this is nil if this is the state machine's first entered state
    func didEnter<E: Event>(from previous: Self?, because event: E)

    /// Called by StateMachine when it is updated.
    /// - Parameter deltaTime: the time, in seconds, since the last update
    func update(_ deltaTime: TimeInterval)

    /// Called by StateMachine when this state is exited.
    /// - Parameter next: the state that is being entered next
    func willExit<E: Event>(to next: Self, because event: E)
}

extension State {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    /// Does nothing.
    public func didEnter<E: Event>(from previous: Self?, because event: E) {}

    /// Does nothing.
    public func update(_ deltaTime: TimeInterval) {}

    /// Does nothing.
    public func willExit<E: Event>(to next: Self, because event: E) {}
}
