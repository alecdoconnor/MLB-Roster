//
//  PlayerPositionSelectionDelegate.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

protocol PlayerPositionSelectionDelegate: class {
    func didChangeSelection(withPositions positions: [Position])
}
