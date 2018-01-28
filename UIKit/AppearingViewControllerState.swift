//
//  AppearingViewControllerState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Appearing UIViewController state.
public class AppearingViewControllerState: ViewControllerState {
    public override var hashValue: Int {
        return 0
    }
    
    public override func isValid<E>(next state: ViewControllerState, when event: E) -> Bool where E : Event {
        switch state {
        case is AppearedViewControllerState, is DisappearingViewControllerState:
            return true
        default:
            return false
        }
    }
}
