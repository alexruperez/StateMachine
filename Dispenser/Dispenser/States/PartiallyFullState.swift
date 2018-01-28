/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A state for use in a dispenser's state machine. This state represents when the dispenser is partially full.
*/

import SpriteKit
import StateMachine

class PartiallyFullState: DispenserState {
    public override var hashValue: Int {
        return 1
    }
    
    // MARK: Initialization
    
    required init(game: GameScene) {
        super.init(game: game, associatedNodeName: "PartiallyFullState")
    }
    
    // MARK: State methods

    override func isValid<E>(next state: DispenserState, when event: E) -> Bool where E : Event {
        // This state can only transition to the serve and refilling states.
        switch state {
        case is ServeState, is RefillingState:
            return true

        default:
            return false
        }
    }
}
