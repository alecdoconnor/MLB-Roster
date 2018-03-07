//
//  BattingPosition.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/2/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

enum BattingPosition: UInt8 {
    case Right = 1
    case Left
    case Switch
    case Unknown
}

extension BattingPosition {
    
    func stringValue() -> String {
        switch self.rawValue {
        case 1:
            return "Right"
        case 2:
            return "Left"
        case 3:
            return "Switch"
        default:
            return "Unknown"
        }
    }
    
}

