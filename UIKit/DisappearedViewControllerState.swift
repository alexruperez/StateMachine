//
//  DisappearedViewControllerState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

/// Disappeared UIViewController state.
public class DisappearedViewControllerState: ViewControllerState {
    public override var hashValue: Int {
        return 3
    }
    
    public override func isValid<E>(next state: ViewControllerState, when event: E) -> Bool where E : Event {
        return state is AppearingViewControllerState
    }
}
