//
//  PlayerDetailHeaderTableViewCell.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

class PlayerDetailHeaderTableViewCell: UITableViewCell {
    
    var player: Player? {
        didSet {
            updateCellContents()
        }
    }
    
    @IBOutlet weak var headshotImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var birthLocationLabel: UILabel!
    
    func updateCellContents() {
        if let player = player {
            
            nameLabel.text = player.name.full
            numberLabel.text = "\(player.position.stringValue()) - Number \(player.number)"
            
            let birthLocations: [String] = [player.birthInfo.city, player.birthInfo.state, player.birthInfo.country].filter { $0 != "" }
            birthLocationLabel.text = birthLocations.joined(separator: ", ")
            
            ImageCache.shared.getImage(fromURL: player.headshot, completion: { [weak self] (image, url) in
                // Only update the picture if the cell's player is still the same
                if self?.player?.headshot == url {
                    DispatchQueue.main.async {
                        self?.headshotImageView.image = image
                    }
                }
            })
        } else {
            nameLabel.text = ""
            numberLabel.text = ""
            birthLocationLabel.text = ""
            headshotImageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        headshotImageView.layer.masksToBounds = true
//        headshotImageView.layer.cornerRadius = headshotImageView.frame.width / 2
    }


}
