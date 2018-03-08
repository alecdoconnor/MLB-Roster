//
//  CoreDataOperation.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/7/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit
import CoreData

class CoreDataOperation: Operation {
    
    let context: NSManagedObjectContext
    
    override init() {
        
        // Generate a background context to perform the work on
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
        
    }
    
}
