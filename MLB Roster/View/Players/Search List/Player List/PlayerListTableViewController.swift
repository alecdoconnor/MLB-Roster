//
//  PlayerListTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

struct PlayerSearchCriteria {
    var firstName: String
    var lastName: String
    var positions: [Position]
}

class PlayerListTableViewController: UITableViewController {
    
    var players = [Player]()
    var isSearchFinished = false
    
    var searchCriteria: PlayerSearchCriteria?
    
    var searchOperation: NetworkOperation<[Player]>!
    var queue = OperationQueue()
    
    let playerCellHeight: CGFloat = 88

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Players"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshData()
    }
    
    // MARK: - Data Source Methods
    
    func refreshData() {
        
        // Gather URLRequest for data task
        // Verify search request is allowed, or return user to search screen with error
        guard let request = RequestFactory.getPlayers(byFirstName: searchCriteria?.firstName ?? "", lastName: searchCriteria?.lastName ?? "") else {
            let alert = AlertFactory.genericError()
            present(alert, animated: true, completion: {
                self.navigationController?.popViewController(animated: true)
            })
            return
        }
        
        // Create a network operation for searching players
        searchOperation = NetworkOperation<[Player]>(request: request)
        
        searchOperation!.completionBlock = { [weak self] in
            
            // Verify results of operation
            guard let newPlayers = self?.searchOperation?.response else {
                // No teams provided from NetworkOperation, provide error alert
                DispatchQueue.main.async {
                    let alert = AlertFactory.genericError()
                    self?.present(alert, animated: true, completion: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
                return
            }
            
            // Store Results and Reload Table
            if (self?.searchCriteria?.positions.count ?? 0) > 0 {
                // If search criteria for positions is provided, filter that data here
                let positionCriteria = self?.searchCriteria?.positions ?? [Position]()
                self?.players = newPlayers.filter { positionCriteria.contains($0.position) }
            } else {
                // If no position criteria is provided, save all positions
                self?.players = newPlayers
            }
            
            // Alert view to reload data, or display a "No Data" cell if no data is available
            self?.isSearchFinished = true
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        queue.addOperation(searchOperation)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchFinished && players.count == 0 {
            return 1
        }
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Check if any players were returned from the search
        if isSearchFinished && players.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No Players Found"
            cell.selectionStyle = .none
            return cell
        }
        
        // Generate instance of referenced object for cell
        let player = players[indexPath.row]
        
        // Dequeue cell for reuse, then inject player object
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerListTableViewCell", for: indexPath) as! PlayerListTableViewCell
        cell.player = player
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // If a "No Data" cell is tapped, ignore it
        if isSearchFinished && players.count == 0 {
            return
        }
        
        // If a player is tapped, segue to a detailed player view
        let player = players[indexPath.row]
        performSegue(withIdentifier: "PlayerDetailTableViewControllerSegue", sender: player)
    }
    
    // MARK: Table View Stylistic Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return playerCellHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // If we are transitioning to a detailed player view, populate it with a Player
        if segue.identifier == "PlayerDetailTableViewControllerSegue",
            let destination = segue.destination as? PlayerDetailTableViewController,
            let player = sender as? Player {
            
            destination.player = player
        }
    }

}
