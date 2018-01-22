//
//  NotRunningApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Not running application state.
public class NotRunningApplicationState: ApplicationState {
    
    public override func isValidNext<S: State>(state type: S.Type) -> Bool {
        return type is InactiveApplicationState.Type
    }
}
