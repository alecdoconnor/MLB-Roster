//
//  CoreDataTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/7/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>! {
        didSet {
            executeFetchRequest()
        }
    }
    
    func executeFetchRequest() {
        
        fetchedResultsController.delegate = self
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Unable to perform fetch on Core Data Table View Controller")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultsController.sections?[section].name
    }
    
    
    // Must be overridden in subclasses:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Must override cellForRowAt when subclassing CoreDataTableViewController
        fatalError("Must override cellForRowAt when subclassing CoreDataTableViewController")
    }
    
}

extension CoreDataTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            tableView.reloadSections(IndexSet(integer: sectionIndex), with: .fade)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
