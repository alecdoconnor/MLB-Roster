//
//  League.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/2/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

enum League: Int {
    case American = 1
    case National
    case Unknown
}

extension League {
    
    func stringValue() -> String {
        switch self.rawValue {
        case 1:
            return "American"
        case 2:
            return "National"
        default:
            return "Unknown"
        }
    }
    
}
