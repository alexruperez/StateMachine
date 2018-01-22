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
    
    public override func isValidNext<S: State>(state type: S.Type) -> Bool {
        switch type {
        case is BackgroundApplicationState.Type, is NotRunningApplicationState.Type:
            return true
        default:
            return false
        }
    }
}
