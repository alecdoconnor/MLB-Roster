//
//  PlayerPositionSelectionTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

class PlayerPositionSelectionTableViewController: UITableViewController {
    
    // MARK: Parameters

    let allPositions: [Position] = [.Pitcher, .Catcher, .FirstBase, .SecondBase,
                                       .ThirdBase, .Shortstop, .LeftField, .CenterField,
                                       .RightField, .DesignatedHitter, .StartingPitcher, .ReliefPitcher]
    
    var selectedPositions = [Position]()
    
    weak var delegate: PlayerPositionSelectionDelegate?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPositions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let position = allPositions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedPositionCell", for: indexPath)
        cell.textLabel?.text = position.stringValue()
        cell.accessoryType = selectedPositions.contains(position) ? .checkmark : .none
        cell.setSelected(selectedPositions.contains(position), animated: false)
        return cell
    }
    
    // MARK: Handle changes to selections
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = allPositions[indexPath.row]
        positionTouched(position: position, in: tableView, at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let position = allPositions[indexPath.row]
        positionTouched(position: position, in: tableView, at: indexPath)
    }
    
    func positionTouched(position: Position, in tableView: UITableView, at indexPath: IndexPath) {
        
        // Determine if this position is already selected
        let isSelectedPosition: Bool = !selectedPositions.contains(position)
        
        // Add or remove from stored array
        if isSelectedPosition {
            selectedPositions.append(position)
        } else {
            selectedPositions = selectedPositions.filter { $0 != position }
        }
        
        // Update checkmark
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = isSelectedPosition ? .checkmark : .none
        
        // Notify delegate (PlayerSearchController) of change
        delegate?.didChangeSelection(withPositions: selectedPositions)
    }

}
