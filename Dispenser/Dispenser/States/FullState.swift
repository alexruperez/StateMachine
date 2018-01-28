/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A state for use in a dispenser's state machine. This state represents when the dispenser is full. It turns on the dispenser's indicator light.
*/

import SpriteKit
import StateMachine

class FullState: DispenserState {
    public override var hashValue: Int {
        return 0
    }
    
    // MARK: Initialization
    
    required init(game: GameScene) {
        super.init(game: game, associatedNodeName: "FullState")
    }
    
    // MARK: State methods

    override func didEnter<E>(from previous: DispenserState?, because event: E) where E : Event {
        // Turn on the indicator light with a green color.
        super.didEnter(from: previous, because: event)
        let greenColor = SKColor.green
        changeIndicatorLightToColor(greenColor)
    }

    override func willExit<E>(to next: DispenserState, because event: E) where E : Event {
        // Turn off the indicator light.
        super.willExit(to: next, because: event)
        let blackColor = SKColor.black
        changeIndicatorLightToColor(blackColor)
    }

    override func isValid<E>(next state: DispenserState, when event: E) -> Bool where E : Event {
        // This state can only transition to the serve state.
        return state is ServeState
    }
}
