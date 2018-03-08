//
//  SavePersistentTeamsOperation.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/7/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation
import CoreData

class SavePersistentTeamsOperation: CoreDataOperation {
    
    var teams: [Team]?
    
    override init() {
        // Initialize CoreDataOperation
        super.init()
        
        // Allow updated teams in network request to overwrite stored teams (By TeamID)
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
    }
    
    override func start() {
        
        // Check if this operation is still valid
        guard !isCancelled else {
            return
        }
        
        // Generate the teams before beginning operation
        
        // Grab previous network operation
        guard let networkDependencyOperation = dependencies.last as? NetworkOperation<[Team]> else {
            print("SavePersistentTeamsOperation did not have the proper NetworkOperation<[Team]> dependency")
            return
        }
        
        // Gather teams from previous operation, if available
        guard let teams = networkDependencyOperation.response else {
            print("SavePersistentTeamsOperation completed early due to invalid [Team]")
            return
        }
        self.teams = teams
        
        // Continue execution of this operation
        main()
        
    }
    
    override func main() {
        
        // Check if this operation is still valid
        guard !isCancelled else {
            return
        }
        
        // Verify that teams is not nil
        guard let teams = teams else {
            return
        }
        
        // Create the NSManagedObjects
        for team in teams {
            // Create a new team, or merge with the existing team, on the current background context
            let _ = PersistentTeam(team: team, context: context)
        }
        
        do {
            try context.save()
            print("Teams saved with Core Data")
        } catch {
            print("ERROR: Unable to save SavePersistentTeamsOperation: \n   \(error)")
        }
        
    }
    
}
