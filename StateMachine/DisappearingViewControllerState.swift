//
//  DisappearingViewControllerState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

public class DisappearingViewControllerState: ViewControllerState {
    
    public override func isValidNext<S: State>(state type: S.Type) -> Bool {
        switch type {
        case is DisappearedViewControllerState.Type, is AppearingViewControllerState.Type:
            return true
        default:
            return false
        }
    }
}
