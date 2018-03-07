//
//  TeamListTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

class TeamListTableViewController: UITableViewController {
    
    var teams = [Team]() {
        didSet {
            americanTeams = teams.filter { $0.league == League.American }.sorted { $0.name < $1.name }
            nationalTeams = teams.filter { $0.league == League.National }.sorted { $0.name < $1.name }
        }
    }
    
    var americanTeams = [Team]()
    var nationalTeams = [Team]()
    
    var teamOperation: NetworkOperation<[Team]>!
    var queue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MLB Teams"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshData()
    }
    
    // MARK: - Data accessors
    
    func refreshData() {
        
        // Gather URLRequest for data task
        let request = RequestFactory.getTeams()
        
        // Create network operation for data task
        teamOperation = NetworkOperation<[Team]>(request: request)
        teamOperation!.completionBlock = { [weak self] in
            
            // Verify results of operation
            guard let newTeams = self?.teamOperation?.response else {
                // No teams provided from NetworkOperation, provide error alert
                DispatchQueue.main.async {
                    let alert = AlertFactory.customError(title: "There was a problem loading the teams", message: "Please try again")
                    self?.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            // Store Results and Reload Table
            self?.teams = newTeams
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        queue.addOperation(teamOperation)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "American"
        case 1:
            return "National"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return americanTeams.count
        case 1:
            return nationalTeams.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a reference copy of the relative team
        let team = (indexPath.section == 0) ? americanTeams[indexPath.row] : nationalTeams[indexPath.row]
        
        // Dequeue cell and populate data
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamListTableViewCell", for: indexPath)
        
        cell.textLabel?.text = team.name
        cell.detailTextLabel?.text = team.city
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create a reference copy of the relative team
        let team = (indexPath.section == 0) ? americanTeams[indexPath.row] : nationalTeams[indexPath.row]
        
        // Open detailed team view
        let teamDetailTableViewController = TeamDetailTableViewController(withTeam: team)
        navigationController?.pushViewController(teamDetailTableViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Show a blank view instead of a continuous line of empty cells, before data is loaded
        return UIView()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
