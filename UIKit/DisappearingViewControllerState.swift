//
//  DisappearingViewControllerState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Disappearing UIViewController state.
public class DisappearingViewControllerState: ViewControllerState {
    public override var hashValue: Int {
        return 2
    }

    public override func isValid<E>(next state: ViewControllerState, when event: E) -> Bool where E : Event {
        switch state {
        case is DisappearedViewControllerState, is AppearingViewControllerState:
            return true
        default:
            return false
        }
    }
}
