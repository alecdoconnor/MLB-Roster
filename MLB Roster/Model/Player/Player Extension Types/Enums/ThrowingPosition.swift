//
//  ThrowingPosition.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/2/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

enum ThrowingPosition: UInt8 {
    case Right = 1
    case Left
    case Unknown
}

extension ThrowingPosition {
    
    func stringValue() -> String {
        switch self.rawValue {
        case 1:
            return "Right"
        case 2:
            return "Left"
        default:
            return "Unknown"
        }
    }
    
}

