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
    
    public override func isValid<E>(next state: ApplicationState, when event: E) -> Bool where E : Event {
        return state is InactiveApplicationState
    }
}
