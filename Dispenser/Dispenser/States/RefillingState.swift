/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A state for use in a dispenser's state machine. This state refills the dispenser with water. It plays a refill animation before exiting.
*/

import SpriteKit
import StateMachine

class RefillingState: DispenserState {
    public override var hashValue: Int {
        return 3
    }
    
    // MARK: Properties
    
    /// A multiplier for the speed of the refilling animation.
    static let timeScale: CGFloat = 5
    
    /**
        The initial height of the water sprite. Used for calculations in the 
        `playRefillAnimationThenExit(_:)` method.
    */
    static let waterNodeHeight: CGFloat = 280
    
    // MARK: Initialization
    
    required init(game: GameScene) {
        super.init(game: game, associatedNodeName: "RefillingState")
    }
    
    // MARK: State methods

    override func didEnter<E>(from previous: DispenserState?, because event: E) where E : Event {
        super.didEnter(from: previous, because: event)
        playRefillAnimationThenExit()
    }

    override func isValid<E>(next state: DispenserState, when event: E) -> Bool where E : Event {
        // This state can only transition to the full state.
        return state is FullState
    }
    
    // MARK: Other Game Logic
    
    /**
        Plays the refill animation, then transitions the state machine into the 
        Full state.
    */
    func playRefillAnimationThenExit() {
        // Grab the sprite node for the dispenser's water from the scene.
        let waterNode = game.childNode(withName: "//water") as! SKSpriteNode
        
        // Calculate the duration of the refilling animation.
        let waterRatio = (RefillingState.waterNodeHeight - waterNode.size.height) / RefillingState.waterNodeHeight
        let refillTime = TimeInterval(RefillingState.timeScale * waterRatio)
        
        /*
            Create and play the animation, then tell the state machine to enter 
            the full state.
        */
        let refillAction = SKAction(named: "refillDispenser", duration: refillTime)!
        
        waterNode.run(refillAction, completion: {
            _ = self.game.stateMachine[self.game.serve]
        }) 
    }
}
