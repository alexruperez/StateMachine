//
//  ViewControllerState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// UIViewController event.
public class ViewControllerEvent: Event {
    public var hashValue: Int {
        return -1
    }
}

/// UIViewController state.
public class ViewControllerState: State {
    public var hashValue: Int {
        return -1
    }
    
    /// Indicates whether this state has been reached with an animation.
    public internal(set) var animated = false

    public func isValid<E>(next state: ViewControllerState, when event: E) -> Bool where E : Event {
        return false
    }
}
