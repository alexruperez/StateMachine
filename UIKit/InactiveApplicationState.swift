//
//  InactiveApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Inactive application state.
public class InactiveApplicationState: ApplicationState {
    
    override init() {
        super.init()
        applicationState = .inactive
    }

    public override func isValid<E>(next state: ApplicationState, when event: E) -> Bool where E : Event {
        switch state {
        case is ActiveApplicationState, is BackgroundApplicationState:
            return true
        default:
            return false
        }
    }
}
