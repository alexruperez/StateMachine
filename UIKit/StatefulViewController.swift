//
//  StatefulViewController.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import UIKit

/// UIViewController subclass with life cycle state machine.
open class StatefulViewController: UIViewController {

    /// UIViewController life cycle state machine.
    public let stateMachine = StateMachine<ViewControllerState, ViewControllerEvent>(initial: DisappearedViewControllerState())
    private let event = ViewControllerEvent()

    open override func viewDidLoad() {
        super.viewDidLoad()
        let appearing = AppearingViewControllerState()
        let appeared = AppearedViewControllerState()
        let disappearing = DisappearingViewControllerState()
        let disappeared = stateMachine.current
        stateMachine[disappeared] = [event: appearing]
        stateMachine[appearing] = [event: appeared]
        stateMachine[appeared] = [event: disappearing]
        stateMachine[disappearing] = [event: disappeared]
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stateMachine[event]?.animated = animated
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stateMachine[event]?.animated = animated
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stateMachine[event]?.animated = animated
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stateMachine[event]?.animated = animated
    }
}
