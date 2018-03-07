//
//  AsyncState.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/4/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

enum AsyncState: String {
    case ready = "isReady"
    case executing = "isExecuting"
    case finished = "isFinished"
}
