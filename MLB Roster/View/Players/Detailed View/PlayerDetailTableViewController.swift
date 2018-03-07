//
//  PlayerDetailTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

enum PlayerDetailTableViewSections {
    case Header
    case Pitching(PitchingStats)
    case Batting(BattingStats)
}

class PlayerDetailTableViewController: UITableViewController {
    
    // Data parameters
    var player: Player!
    
    // Table View Organization parameters
    var sections = [PlayerDetailTableViewSections]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Network operation parameters
    var statsOperation: NetworkOperation<Stats>!
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Start table with basic header info
        sections.append(.Header)
        
        getStats()
    }
    
    func getStats() {
        
        // Gather URLRequest for data task
        let request = RequestFactory.getPlayerStats(byId: player.id)
        
        // Create a network operation for gathering a player's stats
        statsOperation = NetworkOperation<Stats>(request: request)
        
        statsOperation!.completionBlock = { [weak self] in
            
            // Verify results of operation
            guard let stats = self?.statsOperation?.response else {
                // No stats provided from NetworkOperation, provide error alert
                DispatchQueue.main.async {
                    let alert = AlertFactory.genericError()
                    self?.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            // Add the appropriate pitching sections to the table view
            //      Only use the three most recent years
            let pitchingStats = stats.pitching.sorted { $0.yearId > $1.yearId }.prefix(3)
            for pitchingStat in pitchingStats {
                self?.sections.append(.Pitching(pitchingStat))
            }
            
            // Add the appropriate batting sections to the table view
            //      Only use the three most recent years
            let battingStats = stats.batting.sorted { $0.yearId > $1.yearId }.prefix(3)
            for battingStat in battingStats {
                self?.sections.append(.Batting(battingStat))
            }
            
            // Save data to class and refresh relevant sections
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        queue.addOperation(statsOperation)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .Header:
            return 1
        case .Pitching(let pitchingStats):
            return pitchingStats.usefulStatistics.count
        case .Batting(let battingStats):
            return battingStats.usefulStatistics.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .Header:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerDetailHeaderTableViewCell", for: indexPath) as! PlayerDetailHeaderTableViewCell
                cell.player = player
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerDetailTeamTableViewCell", for: indexPath)
                cell.textLabel?.text = "\(player.teamId)"
                return cell
            } else {
                return UITableViewCell()
            }
        case .Pitching(let pitchingStats):
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetailCell", for: indexPath)
            let (cellStatsTitle, cellStatsDetail) = pitchingStats.usefulStatistics[indexPath.row]
            cell.textLabel?.text = cellStatsTitle
            cell.detailTextLabel?.text = cellStatsDetail
            return cell
        case .Batting(let battingStats):
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetailCell", for: indexPath)
            let (cellStatsTitle, cellStatsDetail) = battingStats.usefulStatistics[indexPath.row]
            cell.textLabel?.text = cellStatsTitle
            cell.detailTextLabel?.text = cellStatsDetail
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 && indexPath.row == 0) ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .Header:
            return ""
        case .Batting(let stats):
            return "Batting \(stats.yearId)"
        case .Pitching(let stats):
            return "Pitching \(stats.yearId)"
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
