//
//  PlayerListTableViewCell.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

class PlayerListTableViewCell: UITableViewCell {

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
            print("Update team name after Core Data")
            secondarySubheadLabel.text = "Team Name"
            
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // After adding core data, we will have use for the SecondarySubheadLabel
        // Team names for players will be grabbed with a fetch request
        secondarySubheadLabel.isHidden = true
    }

}
