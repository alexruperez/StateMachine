/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A state for use in a dispenser's state machine. This state represents when the dispenser is full. It turns on the dispenser's indicator light.
*/

import SpriteKit
import StateMachine

class FullState: DispenserState {
    
    // MARK: Initialization
    
    required init(game: GameScene) {
        super.init(game: game, associatedNodeName: "FullState")
    }
    
    // MARK: State methods
    
    override func didEnter(from previousState: State?) {
        super.didEnter(from: previousState)
        // Turn on the indicator light with a green color.
        let greenColor = SKColor.green
        changeIndicatorLightToColor(greenColor)
    }
    
    override func willExit(to nextState: State) {
        super.willExit(to: nextState)
        // Turn off the indicator light.
        let blackColor = SKColor.black
        changeIndicatorLightToColor(blackColor)
    }

    override func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        // This state can only transition to the serve state.
        return type is ServeState.Type
    }
}
