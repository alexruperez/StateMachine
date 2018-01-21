//
//  BackgroundApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

public class BackgroundApplicationState: ApplicationState {
    
    override init() {
        super.init()
        applicationState = .background
    }

    public override func isValidNext<S: State>(state type: S.Type) -> Bool {
        switch type {
        case is InactiveApplicationState.Type, is SuspendedApplicationState.Type:
            return true
        default:
            return false
        }
    }
}
