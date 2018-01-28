//
//  Event.swift
//  StateMachine
//
//  Created by Alex Rupérez on 27/1/18.
//  Copyright © 2018 alexruperez. All rights reserved.
//

import Foundation

public protocol Event: Hashable {

}

extension Event {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
