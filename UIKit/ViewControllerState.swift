//
//  ViewControllerState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// UIViewController state.
public class ViewControllerState: State {

    /// Indicates whether this state has been reached with an animation.
    public internal(set) var animated = false

    public func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        return false
    }
}
