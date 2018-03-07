//
//  Stats.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct Stats: Decodable {
    
    let batting: [BattingStats]
    let pitching: [PitchingStats]
    
    enum CodingKeys: String, CodingKey {
        
        case batting = "Batting"
        case pitching = "Pitching"
        
    }
    
}


