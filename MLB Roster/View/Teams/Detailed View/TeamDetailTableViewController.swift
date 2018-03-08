//
//  TeamDetailTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit
import CoreData

class TeamDetailTableViewController: CoreDataTableViewController {
    
    let context: NSManagedObjectContext
    
    let team: Team
    
    init(withTeam team: Team) {
        // Team is a required parameter that must be specified when initialized
        self.team = team
        
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Continue initializing table view
        super.init(nibName: "TeamDetailTableViewController", bundle: nil)
        
        // Define the fetch request that powers this table view
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersistentPlayer")
        fetchRequest.predicate = NSPredicate(format: "teamId == %d", team.id)
        let positionSortDescriptor = NSSortDescriptor(key: "positionString", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "fullName", ascending: true)
        fetchRequest.sortDescriptors = [positionSortDescriptor, nameSortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "positionString", cacheName: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = team.fullName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        refreshData()
    }
    
    // MARK: - Data accessors
    
    func refreshData() {

    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a reference copy of the relative player
        let player = fetchedResultsController?.object(at: indexPath) as! PersistentPlayer
        
        // Dequeue cell and populate data
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")
        cell?.accessoryType = .disclosureIndicator
        
        cell?.textLabel?.text = player.fullName

        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create a reference copy of the relative team
        let persistentPlayer = fetchedResultsController?.object(at: indexPath) as! PersistentPlayer
        let player = persistentPlayer.returnPlayer()

        // Open detailed team view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playerDetailTableViewController = storyboard.instantiateViewController(withIdentifier: "PlayerDetailTableViewController") as! PlayerDetailTableViewController
        playerDetailTableViewController.player = player
        navigationController?.pushViewController(playerDetailTableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Show a blank view instead of a continuous line of empty cells, before data is loaded
        return UIView()
    }
    
}
