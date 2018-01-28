//
//  AppearedViewControllerState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Appeared UIViewController state.
public class AppearedViewControllerState: ViewControllerState {
    public override var hashValue: Int {
        return 1
    }
    
    public override func isValid<E>(next state: ViewControllerState, when event: E) -> Bool where E : Event {
        return state is DisappearingViewControllerState
    }
}
