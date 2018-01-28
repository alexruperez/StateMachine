//
//  SuspendedApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Suspended application state.
public class SuspendedApplicationState: ApplicationState {
    
    public override func isValid<E>(next state: ApplicationState, when event: E) -> Bool where E : Event {
        switch state {
        case is BackgroundApplicationState, is NotRunningApplicationState:
            return true
        default:
            return false
        }
    }
}
