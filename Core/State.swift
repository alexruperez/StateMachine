//
//  State.swift
//  StateMachine
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Represents a single state in a state machine.
public protocol State {
    /// Returns true if the given class is a valid next state to enter.
    /// Implement this method to enforce limited edge traversals in the state machine.
    /// - Parameter type: the class to be checked
    /// - Returns: true if the state transition is valid, else false
    func isValidNext<S: State>(state type: S.Type) -> Bool

    /// Called by StateMachine when this state is entered.
    /// - Parameter previous: the state that was exited to enter this state, this is nil if this is the state machine's first entered state
    func didEnter(from previous: State?)

    /// Called by StateMachine when it is updated.
    /// - Parameter deltaTime: the time, in seconds, since the last update
    func update(_ deltaTime: TimeInterval)

    /// Called by StateMachine when this state is exited.
    /// - Parameter next: the state that is being entered next
    func willExit(to next: State)
}

extension State {
    /// Does nothing.
    public func didEnter(from previous: State?) {}

    /// Does nothing.
    public func update(_ deltaTime: TimeInterval) {}

    /// Does nothing.
    public func willExit(to next: State) {}
}
