//
//  Name.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/1/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct Name: Decodable {
    
    var full: String
    var formal: String
    
    var last: String
    var first: String
    var uses: String
    var middle: String?
    
    // Chose to use a String instead of a Char for added benefits of String, and to match API's usage
    var firstInitial: String
    var lastInitial: String
    
    enum CodingKeys: String, CodingKey {
        
        case full = "FullName"
        case formal = "FormalName"
        
        case last = "LastName"
        case first = "FirstName"
        case uses = "UsesName"
        case middle = "MiddleName"
        
        case firstInitial = "FirstInitial"
        case lastInitial = "LastInitial"
        
    }
    
}
