//
//  PersistentTeam.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation
import CoreData

extension PersistentTeam {
    
    convenience init(team: Team, context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.abbreviation = team.abbreviation
        self.city = team.city
        self.fullName = team.fullName
        self.id = Int16(team.id)
        self.league = Int16(team.league.rawValue)
        self.leagueString = team.league.stringValue()
        self.name = team.name
        
    }
    
    func returnTeam() -> Team {
        // Return player object from properties
        return Team(id: Int(self.id),
                    city: self.city ?? "",
                    name: self.name ?? "",
                    abbreviation: self.abbreviation ?? "",
                    fullName: self.fullName ?? "",
                    league: League(rawValue: Int(self.league)) ?? .Unknown)
    }
    
}
