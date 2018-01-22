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
    public let stateMachine = StateMachine([DisappearedViewControllerState(),
                                            AppearingViewControllerState(),
                                            AppearedViewControllerState(),
                                            DisappearingViewControllerState()])

    open override func viewDidLoad() {
        super.viewDidLoad()
        stateMachine.enter(DisappearedViewControllerState.self)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (stateMachine.state(AppearingViewControllerState.self) as? ViewControllerState)?.animated = animated
        stateMachine.enter(AppearingViewControllerState.self)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (stateMachine.state(AppearedViewControllerState.self) as? ViewControllerState)?.animated = animated
        stateMachine.enter(AppearedViewControllerState.self)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (stateMachine.state(DisappearingViewControllerState.self) as? ViewControllerState)?.animated = animated
        stateMachine.enter(DisappearingViewControllerState.self)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (stateMachine.state(DisappearedViewControllerState.self) as? ViewControllerState)?.animated = animated
        stateMachine.enter(DisappearedViewControllerState.self)
    }
}
