//
//  PlayerSearchTableViewController.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

class PlayerSearchTableViewController: UITableViewController {
    
    // MARK: Parameters
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var positionSelectionLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    var firstName = "" {
        didSet {
            updateSubmitButton()
        }
    }
    
    var lastName = "" {
        didSet {
            updateSubmitButton()
        }
    }
    
    var selectedPositions = [Position]() {
        didSet {
            updateSubmitButton()
        }
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        performSearch()
    }
    
    var minimumNameSearchLength = 2
    var searchShouldBeEnabled: Bool {
        return
            firstName.count >= minimumNameSearchLength ||
            lastName.count >= minimumNameSearchLength ||
            selectedPositions.count > 0
    }
    
    
    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.addTarget(self, action: #selector(firstNameUpdated), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(lastNameUpdated), for: .editingChanged)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        addTapRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        positionSelectionLabel.text = getSummaryForSelectedPositions()
        updateSubmitButton()
    }
    
    
    // MARK: View Assisting Methods
    
    func addTapRecognizer() {
        // When a tap is detected, close the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: Table View Data Methods
    
    @objc func firstNameUpdated() {
        firstName = firstNameTextField.text ?? ""
    }
    
    @objc func lastNameUpdated() {
        lastName = lastNameTextField.text ?? ""
    }
    
    func getSummaryForSelectedPositions() -> String {
        if selectedPositions.count == 0 {
            return "All Positions"
        } else {
            return selectedPositions.map { $0.stringValue() }.joined(separator: ", ")
        }
    }
    
    func updateSubmitButton() {
        searchButton.isEnabled = searchShouldBeEnabled
    }
    
    func performSearch() {
        // Search only if a valid value is provided to search by
        if searchShouldBeEnabled {
            firstNameUpdated()
            lastNameUpdated()
            performSegue(withIdentifier: "PlayerListTableViewControllerSegue", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    // If navigating to the Position Selection view, inject both delegate and current selection dependencies
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayerPositionSelectionTableViewControllerSegue",
            let destination = segue.destination as? PlayerPositionSelectionTableViewController {
            destination.delegate = self
            destination.selectedPositions = selectedPositions
        } else if segue.identifier == "PlayerListTableViewControllerSegue",
            let destination = segue.destination as? PlayerListTableViewController {
            destination.searchCriteria = PlayerSearchCriteria(firstName: firstName, lastName: lastName, positions: selectedPositions)
        }
    }

}

extension PlayerSearchTableViewController: PlayerPositionSelectionDelegate {
    
    // Handle Player Position selection view controller changes to selected positions
    func didChangeSelection(withPositions positions: [Position]) {
        
        selectedPositions = positions
    }
    
}

extension PlayerSearchTableViewController: UITextFieldDelegate {
    
    // Detect search from TextField's keyboard, hide keyboard, and perform search
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        dismissKeyboard()
        performSearch()
        return true
    }
    
}
