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
    
    public override func isValidNext<S: State>(state type: S.Type) -> Bool {
        switch type {
        case is AppearedViewControllerState.Type, is DisappearingViewControllerState.Type:
            return true
        default:
            return false
        }
    }
}
