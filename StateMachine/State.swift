//
//  State.swift
//  StateMachine
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

public protocol State {
    func isValidNext<S: State>(state type: S.Type) -> Bool

    func didEnter(from previous: State?)

    func update(_ deltaTime: TimeInterval)

    func willExit(to next: State)
}

extension State {
    public func didEnter(from previous: State?) {}

    public func update(_ deltaTime: TimeInterval) {}

    public func willExit(to next: State) {}
}
