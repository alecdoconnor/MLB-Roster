//
//  TeamListTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit
import CoreData

class TeamListTableViewController: CoreDataTableViewController {
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MLB Teams"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        createFetchRequestController()
    }
    
    func createFetchRequestController() {
        
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Define the fetch request that powers this table view
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersistentTeam")
        let positionSortDescriptor = NSSortDescriptor(key: "leagueString", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [positionSortDescriptor, nameSortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "leagueString", cacheName: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a reference copy of the relative team
        let team = fetchedResultsController.object(at: indexPath) as! PersistentTeam
        
        // Dequeue cell and populate data
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamListTableViewCell", for: indexPath)
        
        cell.textLabel?.text = team.name
        cell.detailTextLabel?.text = team.city
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create a reference copy of the relative team
        let persistentTeam = fetchedResultsController.object(at: indexPath) as! PersistentTeam
        let team = persistentTeam.returnTeam()
        
        // Open detailed team view
        let teamDetailTableViewController = TeamDetailTableViewController(withTeam: team)
        navigationController?.pushViewController(teamDetailTableViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Show a blank view instead of a continuous line of empty cells, before data is loaded
        return UIView()
    }

}
