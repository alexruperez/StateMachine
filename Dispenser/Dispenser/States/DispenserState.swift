/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A superclass for states powering the dispenser.
*/

import SpriteKit
import StateMachine

class DispenserState: State {
    // MARK: Properties
    
    /// A reference to the game scene, used to alter sprites.
    let game: GameScene
    
    /// The name of the node in the game scene that is associated with this state.
    let associatedNodeName: String
    
    /// Convenience property to get the state's associated sprite node.
    var associatedNode: SKSpriteNode? {
        return game.childNode(withName: "//\(associatedNodeName)") as? SKSpriteNode
    }
    
    // MARK: Initialization
    
    init(game: GameScene, associatedNodeName: String) {
        self.game = game
        self.associatedNodeName = associatedNodeName
    }
    
    // MARK: State methods

    func isValidNext<S>(state type: S.Type) -> Bool where S : State {
        return false
    }
    
    /// Highlights the sprite representing the state.
    func didEnter(from previous: State?) {
        guard let associatedNode = associatedNode else { return }
        associatedNode.color = SKColor.lightGray
    }
    
    /// Unhighlights the sprite representing the state.
    func willExit(to next: State) {
        guard let associatedNode = associatedNode else { return }
        associatedNode.color = SKColor.darkGray
    }
    
    // MARK: Methods

    /// Changes the dispenser's indicator light to the specified color.
    func changeIndicatorLightToColor(_ color: SKColor) {
        let indicator = game.childNode(withName: "//indicator") as! SKSpriteNode
        indicator.color = color
    }
}
