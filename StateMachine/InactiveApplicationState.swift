//
//  InactiveApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

public class InactiveApplicationState: ApplicationState {
    
    override init() {
        super.init()
        applicationState = .inactive
    }

    public override func isValidNext<S: State>(state type: S.Type) -> Bool {
        switch type {
        case is ActiveApplicationState.Type, is BackgroundApplicationState.Type:
            return true
        default:
            return false
        }
    }
}
