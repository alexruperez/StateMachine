//
//  ApplicationStateMachine.swift
//  StateMachine
//
//  Created by Alex Rupérez on 21/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import UIKit

extension UIApplication {
    /// Application life cycle state machine.
    public var stateMachine: ApplicationStateMachine {
        return ApplicationStateMachine.shared
    }
}

extension UIApplicationDelegate {
    /// Application life cycle state machine.
    public var stateMachine: ApplicationStateMachine {
        return ApplicationStateMachine.shared
    }
}

/// A notification dispatch mechanism protocol that enables the broadcast of information to registered observers.
public protocol NotificationCenterProtocol {
    /// Creates a notification with a given name and sender and posts it to the notification center.
    /// - Parameter aName: the name of the notification
    /// - Parameter anObject: the object posting the notification
    func post(name aName: Notification.Name, object anObject: Any?)
    /// Adds an entry to the notification center's dispatch table with an observer and a notification selector,
    /// and an optional notification name and sender.
    /// - Parameter observer: the object registering as an observer
    /// - Parameter aSelector: the selector that specifies the message the receiver sends observer to notify it of the
    /// notification posting, the method specified by aSelector must have one and only one argument (an instance of
    /// Notification)
    /// - Parameter aName: the name of the notification for which to register the observer; that is, only notifications
    /// with this name are delivered to the observer. If you pass nil, the notification center doesn’t use a
    /// notification’s name to decide whether to deliver it to the observer
    /// - Parameter anObject: the object whose notifications the observer wants to receive; that is, only notifications
    /// sent by this sender are delivered to the observer. If you pass nil, the notification center doesn’t use a
    /// notification’s sender to decide whether to deliver it to the observer
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: Notification.Name?, object anObject: Any?)
    /// Removes all entries specifying a given observer from the notification center's dispatch table.
    /// - Parameter observer: the observer to remove
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: NotificationCenterProtocol {}

/// Application life cycle state machine that has a single current state.
public class ApplicationStateMachine: StateMachine<ApplicationState, ApplicationEvent> {

    /// Application life cycle state machine shared instance.
    public static let shared = ApplicationStateMachine()

    /// Notification dispatch mechanism implementation.
    private(set) var notificationCenter: NotificationCenterProtocol!
    /// The running state of the application.
    public var applicationState: UIApplicationState? {
        return current.applicationState
    }
    private let event = ApplicationEvent()
    private let foreground = ForegroundEvent()
    private let background = BackgroundEvent()

    /// Create an application life cycle state machine.
    /// - Parameter notificationCenter: notification dispatch mechanism implementation
    public convenience init(_ notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.init(initial: NotRunningApplicationState())
        let inactive = InactiveApplicationState()
        let active = ActiveApplicationState()
        let backgroundState = BackgroundApplicationState()
        let suspended = SuspendedApplicationState()
        let notRunning = current
        self[notRunning] = [foreground: inactive]
        self[inactive] = [foreground: active]
        self[active] = [foreground: inactive]
        self[inactive] = [background: backgroundState]
        self[backgroundState] = [event: suspended]
        self[backgroundState] = [foreground: inactive]
        self[suspended] = [event: notRunning]
        self.notificationCenter = notificationCenter
        observeApplication()
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
        _ = self[foreground]
    }

    @objc private func applicationDidBecomeActive(_ notification: Notification) {
        _ = self[foreground]
    }

    @objc private func applicationDidEnterBackground(_ notification: Notification) {
        _ = self[background]
    }

    @objc private func applicationWillResignActive(_ notification: Notification) {
        _ = self[foreground]
    }

    @objc private func applicationWillEnterForeground(_ notification: Notification) {
        _ = self[foreground]
    }

    @objc private func applicationWillTerminate(_ notification: Notification) {
        _ = self[event]
    }

    deinit {
        notificationCenter.removeObserver(self)
    }
}
