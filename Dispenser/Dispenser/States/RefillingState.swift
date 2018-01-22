/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A state for use in a dispenser's state machine. This state refills the dispenser with water. It plays a refill animation before exiting.
*/

import SpriteKit
import StateMachine

class RefillingState: DispenserState {
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
    
    override func didEnter(from previousState: State?) {
        super.didEnter(from: previousState)
        playRefillAnimationThenExit()
    }

    override func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        // This state can only transition to the full state.
        return type is FullState.Type
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
            self.game.stateMachine?.enter(FullState.self)
        }) 
    }
}
