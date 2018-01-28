//
//  BackgroundApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Background application state.
public class BackgroundApplicationState: ApplicationState {
    
    override init() {
        super.init()
        applicationState = .background
    }

    public override func isValid<E>(next state: ApplicationState, when event: E) -> Bool where E : Event {
        switch state {
        case is InactiveApplicationState, is SuspendedApplicationState:
            return true
        default:
            return false
        }
    }
}
