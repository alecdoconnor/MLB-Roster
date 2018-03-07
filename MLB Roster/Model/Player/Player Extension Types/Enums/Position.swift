//
//  Position.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/1/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

enum Position: UInt8 {
    
    case Unknown = 0
    case Pitcher
    case Catcher
    case FirstBase
    case SecondBase
    case ThirdBase
    case Shortstop
    case LeftField
    case CenterField
    case RightField
    case DesignatedHitter
    case StartingPitcher
    case ReliefPitcher
    
}

extension Position {
    
    func stringValue() -> String {
        switch self.rawValue {
        case 1:
            return "Pitcher"
        case 2:
            return "Catcher"
        case 3:
            return "First Base"
        case 4:
            return "Second Base"
        case 5:
            return "Third Base"
        case 6:
            return "Shortstop"
        case 7:
            return "Left Field"
        case 8:
            return "Center Field"
        case 9:
            return "Right Field"
        case 10:
            return "Designated Hitter"
        case 11:
            return "Starting Pitcher"
        case 12:
            return "Relief Pitcher"
        default:
            return "Unknown"
        }
    }
    
}
