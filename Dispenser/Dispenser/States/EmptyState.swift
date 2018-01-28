/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A state for use in a dispenser's state machine. This state represents when the dispenser is empty. It flashes the dispenser's warning light.
*/

import SpriteKit
import StateMachine

class EmptyState: DispenserState {
    public override var hashValue: Int {
        return 2
    }

    // MARK: Properties
    
    /// Keeps track of time between indicator light toggles.
    var flashTimeCounter: TimeInterval = 0
    
    /// Defines the time interval between when the light is toggled.
    static let flashInterval = 0.6
    
    /// Changes the color of the indicator light to red or black when toggled.
    var lightOn = true {
        didSet {
            if lightOn {
                let redColor = SKColor.red
                changeIndicatorLightToColor(redColor)
            }
            else {
                let blackColor = SKColor.black
                changeIndicatorLightToColor(blackColor)
            }
        }
    }
    
    // MARK: Initialization
    
    required init(game: GameScene) {
        super.init(game: game, associatedNodeName: "EmptyState")
    }
    
    // MARK: State methods

    override func didEnter<E>(from previous: DispenserState?, because event: E) where E : Event {
        // Turn on the indicator light with a red color.
        super.didEnter(from: previous, because: event)
        let red = SKColor.red
        changeIndicatorLightToColor(red)
    }

    override func willExit<E>(to next: DispenserState, because event: E) where E : Event {
        // Turn on the indicator light with a green color.
        super.willExit(to: next, because: event)
        let black = SKColor.black
        changeIndicatorLightToColor(black)
    }

    override func isValid<E>(next state: DispenserState, when event: E) -> Bool where E : Event {
        // This state can only transition to the refilling state.
        return state is RefillingState
    }

    func update(_ deltaTime: TimeInterval) {
        // Keep track of the time since the last update.
        flashTimeCounter += deltaTime

        /*
         If an interval of `flashInterval` has passed since the previous update,
         toggle the indicator light and reset the time counter.
         */
        if flashTimeCounter > EmptyState.flashInterval {
            lightOn = !lightOn
            flashTimeCounter = 0
        }
    }
}
