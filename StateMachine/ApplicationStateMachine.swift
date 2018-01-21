//
//  ApplicationStateMachine.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import UIKit

extension UIApplication {
    public var stateMachine: ApplicationStateMachine {
        return ApplicationStateMachine.shared
    }
}

extension UIApplicationDelegate {
    public var stateMachine: ApplicationStateMachine {
        return ApplicationStateMachine.shared
    }
}

public protocol NotificationCenterProtocol {
    func post(name aName: NSNotification.Name, object anObject: Any?)
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: NotificationCenterProtocol {}

public class ApplicationStateMachine: StateMachine {
    
    public static let shared = ApplicationStateMachine()

    private(set) var notificationCenter: NotificationCenterProtocol!
    public var applicationState: UIApplicationState? {
        return (current as? ApplicationState)?.applicationState
    }

    public convenience init(_ notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.init([NotRunningApplicationState(),
                   InactiveApplicationState(),
                   ActiveApplicationState(),
                   BackgroundApplicationState(),
                   SuspendedApplicationState()])
        self.notificationCenter = notificationCenter
        observeApplication()
        enter(NotRunningApplicationState.self)
    }

    private func observeApplication() {
        observe(.UIApplicationDidFinishLaunching, #selector(applicationDidFinishLaunching(_:)))
        observe(.UIApplicationDidBecomeActive, #selector(applicationDidBecomeActive(_:)))
        observe(.UIApplicationDidEnterBackground, #selector(applicationDidEnterBackground(_:)))
        observe(.UIApplicationWillResignActive, #selector(applicationWillResignActive(_:)))
        observe(.UIApplicationWillEnterForeground, #selector(applicationWillEnterForeground(_:)))
        observe(.UIApplicationWillTerminate, #selector(applicationWillTerminate(_:)))
    }

    private func observe(_ notification: Notification.Name?, _ selector: Selector) {
        notificationCenter.addObserver(self, selector: selector, name: notification, object: nil)
    }

    @objc private func applicationDidFinishLaunching(_ notification: Notification) {
        enter(InactiveApplicationState.self)
    }

    @objc private func applicationDidBecomeActive(_ notification: Notification) {
        enter(ActiveApplicationState.self)
    }

    @objc private func applicationDidEnterBackground(_ notification: Notification) {
        enter(BackgroundApplicationState.self)
    }

    @objc private func applicationWillResignActive(_ notification: Notification) {
        enter(InactiveApplicationState.self)
    }

    @objc private func applicationWillEnterForeground(_ notification: Notification) {
        enter(InactiveApplicationState.self)
    }

    @objc private func applicationWillTerminate(_ notification: Notification) {
        enter(SuspendedApplicationState.self)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }
}
