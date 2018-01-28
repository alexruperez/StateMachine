//
//  ApplicationState.swift
//  StateMachine
//
//  Created by Alex Rupérez on 20/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import UIKit

/// Application event.
public class ApplicationEvent: Event {
    public var hashValue: Int {
        return -1
    }
}

public class ForegroundEvent: ApplicationEvent {
    public override var hashValue: Int {
        return 0
    }
}

public class BackgroundEvent: ApplicationEvent {
    public override var hashValue: Int {
        return 1
    }
}

/// Application state.
public class ApplicationState: State {
    public var hashValue: Int {
        return -1
    }
    
    /// The running state of the application for this state.
    public internal(set) var applicationState: UIApplicationState?

    public func isValid<E>(next state: ApplicationState, when event: E) -> Bool where E : Event {
        return false
    }
}
