//
//  ActiveApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Active application state.
public class ActiveApplicationState: ApplicationState {
    
    override init() {
        super.init()
        applicationState = .active
    }

    public override func isValidNext<S: State>(state type: S.Type) -> Bool {
        return type is InactiveApplicationState.Type
    }
}
