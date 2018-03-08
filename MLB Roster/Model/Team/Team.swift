//
//  Team.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/2/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct Team: Decodable {
    
    let id: Int
    let city: String
    let name: String
    let abbreviation: String
    let fullName: String
    let league: League
    
    enum CodingKeys: String, CodingKey {
        case id = "TeamID"
        case city = "City"
        case name = "Name"
        case abbreviation = "Abbr"
        case fullName = "FullName"
        case league = "LeagueID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        city = try values.decode(String.self, forKey: .city)
        name = try values.decode(String.self, forKey: .name)
        abbreviation = try values.decode(String.self, forKey: .abbreviation)
        fullName = try values.decode(String.self, forKey: .fullName)
        
        // League Enum
        let rawLeague = try values.decode(Int.self, forKey: .league)
        league = League(rawValue: rawLeague) ?? .Unknown
    }
    
    init(id: Int, city: String, name: String, abbreviation: String, fullName: String, league: League) {
        self.id = id
        self.city = city
        self.name = name
        self.abbreviation = abbreviation
        self.fullName = fullName
        self.league = league
    }
    
}
