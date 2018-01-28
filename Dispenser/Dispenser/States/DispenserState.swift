/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A superclass for states powering the dispenser.
*/

import SpriteKit
import StateMachine

public class DispenserEvent: Event {
    public var hashValue: Int {
        return -1
    }
}

public class ServeEvent: DispenserEvent {
    public override var hashValue: Int {
        return 0
    }
}

public class FillEvent: DispenserEvent {
    public override var hashValue: Int {
        return 1
    }
}

class DispenserState: State {
    public var hashValue: Int {
        return -1
    }
    
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

    func isValid<E>(next state: DispenserState, when event: E) -> Bool where E : Event {
        return false
    }

    /// Highlights the sprite representing the state.
    func didEnter<E>(from previous: DispenserState?, because event: E) where E : Event {
        guard let associatedNode = associatedNode else { return }
        associatedNode.color = SKColor.lightGray
    }

    /// Unhighlights the sprite representing the state.
    func willExit<E>(to next: DispenserState, because event: E) where E : Event {
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
