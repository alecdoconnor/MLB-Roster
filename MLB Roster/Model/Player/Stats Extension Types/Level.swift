//
//  Level.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct Level: Decodable {
    
    let id: Int
    let name: String
    let abbreviation: String
    let sortOrder: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id = "LevelID"
        case name = "Name"
        case abbreviation = "Abbr"
        case sortOrder = "SortOrder"
        
    }
    
}
