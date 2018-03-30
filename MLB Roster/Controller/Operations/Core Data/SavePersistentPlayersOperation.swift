//
//  SavePersistentPlayersOperation.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/7/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation
import CoreData

class SavePersistentPlayersOperation: CoreDataOperation {
    
    var players: [Player]?
    
    override init() {
        // Initialize CoreDataOperation
        super.init()
        
        // Allow updated players in network request to overwrite stored players (By PlayerID)
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
    }
    
    override func main() {
        
        // Check if this operation is still valid
        guard !isCancelled else {
            return
        }
        
        // Generate the players before beginning operation
        
        // Grab previous network operation
        guard let networkDependencyOperation = dependencies.last as? NetworkOperation<[Player]> else {
            print("SavePersistentPlayersOperation did not have the proper NetworkOperation<[Player]> dependency")
            return
        }
        
        // Gather players from previous operation, if available
        guard let players = networkDependencyOperation.response else {
            print("SavePersistentPlayersOperation completed early due to invalid [Player]")
            return
        }
        
        self.players = players
        
        // Check if this operation is still valid
        guard !isCancelled else {
            return
        }
        
        // Create the NSManagedObjects
        for player in players {
            // Create a new player, or merge with the existing player, on the current background context
            let _ = PersistentPlayer(player: player, context: context)
        }
        
        do {
            try context.save()
            print("Players saved with Core Data")
        } catch {
            print("ERROR: Unable to save SavePersistentPlayersOperation: \n   \(error)")
        }
        
    }
    
}

