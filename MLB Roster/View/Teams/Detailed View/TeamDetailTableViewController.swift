//
//  TeamDetailTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

class TeamDetailTableViewController: UITableViewController {
    
    let team: Team
    var players = [Player]()
    var playersByPosition = [Position]()
    
    var rosterOperation: NetworkOperation<[Player]>!
    var queue = OperationQueue()
    
    init(withTeam team: Team) {
        // Team is a required parameter that must be specified when initialized
        self.team = team
        
        // Continue initializing table view
        super.init(nibName: "TeamDetailTableViewController", bundle: nil)
    }
    
    // Not currently using `init(coder:)`
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = team.fullName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshData()
    }
    
    // MARK: - Data accessors
    
    func refreshData() {
        
        // Gather URLRequest for data task
        let request = RequestFactory.getTeamRoster(byId: team.id)
        
        // Create network operation for data task
        rosterOperation = NetworkOperation<[Player]>(request: request)
        rosterOperation!.completionBlock = { [weak self] in
            
            // Verify results of operation
            guard let newPlayers = self?.rosterOperation?.response else {
                // No teams provided from NetworkOperation, provide error alert
                DispatchQueue.main.async {
                    let alert = AlertFactory.customError(title: "There was a problem loading the \(self?.team.name ?? "team")'s roster", message: nil)
                    self?.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            // Store Results and Reload Table
            self?.players = newPlayers
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        queue.addOperation(rosterOperation)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a reference copy of the relative player
        let player = players[indexPath.row]
        
        // Dequeue cell and populate data
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = player.name.full
        cell.detailTextLabel?.text = player.position.stringValue()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create a reference copy of the relative team
        let player = players[indexPath.row]
        
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
