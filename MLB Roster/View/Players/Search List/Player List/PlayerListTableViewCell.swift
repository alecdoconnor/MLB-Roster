//
//  PlayerListTableViewCell.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit
import CoreData

class PlayerListTableViewCell: UITableViewCell {
    
    var context: NSManagedObjectContext!

    @IBOutlet weak var headshotImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var primarySubheadLabel: UILabel!
    @IBOutlet weak var secondarySubheadLabel: UILabel!
    
    var player: Player? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        
        if let player = player {
            
            // Update basic player data
            headlineLabel.text = player.name.full
            primarySubheadLabel.text = player.position.stringValue()
            secondarySubheadLabel.text = getTeamName(forTeamID: player.teamId)
            
            // Update the image
            headshotImageView.image = nil
            ImageCache.shared.getImage(fromURL: player.headshot, completion: { [weak self] (image, url) in
                // Only update the picture if the cell's player is still the same
                if self?.player?.headshot == url {
                    DispatchQueue.main.async {
                        self?.headshotImageView.image = image
                    }
                }
            })
        } else {
            
            // Reset the cell
            headlineLabel.text = ""
            primarySubheadLabel.text = ""
            secondarySubheadLabel.text = ""
            headshotImageView.image = nil
        }
        
        
    }
    
    func getTeamName(forTeamID id: Int) -> String {
        let fetchRequest: NSFetchRequest<PersistentTeam> = PersistentTeam.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.fetchLimit = 1
        
        var team: PersistentTeam?
        
        do {
            // Execute the fetch request and save the first team to a local var
            let fetchResults = try context.fetch(fetchRequest)
            if fetchResults.count > 0,
                let fetchedTeam = fetchResults.first {
                team = fetchedTeam
            }
        } catch {
            print("Player cell unable to gather team: \(error)")
        }
        
        if let team = team,
            let teamName = team.fullName {
            // Display this label
            secondarySubheadLabel.isHidden = false
            
            return teamName
            
        } else {
            // Hide this label
            secondarySubheadLabel.isHidden = true
            
            return ""
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

}
