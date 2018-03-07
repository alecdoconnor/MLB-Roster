//
//  BattingStats.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct BattingStats: Decodable {
    let playerId: Int
    let yearId: Int
    let levelId: UInt8
    let teamId: Int
    let G: Int
    let AB: Int
    let B1: Int
    let B2: Int
    let B3: Int
    let HR: Int
    let UBB: Int
    let HBP: Int
    let SO: Int
    let CI: Int
    let IBB: Int
    let SH: Int
    let SF: Int
    let SB: Int
    let CS: Int
    let PA: Int
    let R: Int
    let RBI: Int
    let team: Team
    let level: Level
    
    enum CodingKeys: String, CodingKey {
        
        // Default keys
        case G, AB, B1, B2, B3, HR, UBB, HBP, SO, CI, IBB, SH, SF, SB, CS, PA, R, RBI
        
        // Custom keys
        case playerId = "PlayerID"
        case yearId = "YearID"
        case levelId = "LevelID"
        case teamId = "TeamID"
        case team = "Team"
        case level = "Level"
        
    }
    
    // Statistical Organizer
    var usefulStatistics: [(String, String)] {
        var dict = [(String, String)]()
        
        dict.append(("Games", "\(G)"))
        dict.append(("At Bats", "\(AB)"))
        dict.append(("Hits", "\(StatCalculations.hits(B1: B1, B2: B2, B3: B3, HR: HR))"))
        dict.append(("Strike Outs", "\(SO)"))
        dict.append(("Walks", "\(StatCalculations.walks(UBB: UBB, IBB: IBB))"))
        dict.append(("AVG", "\(StatCalculations.AVG(B1: B1, B2: B2, B3: B3, HR: HR, AB: AB))"))
        dict.append(("OBP", "\(StatCalculations.OBP(B1: B1, B2: B2, B3: B3, HR: HR, AB: AB, UBB: UBB, IBB: IBB, HBP: HBP, SF: SF))"))
        dict.append(("SLG", "\(StatCalculations.SLG(B1: B1, B2: B2, B3: B3, HR: HR, AB: AB))"))
        dict.append(("OPS", "\(StatCalculations.OPS(B1: B1, B2: B2, B3: B3, HR: HR, AB: AB, UBB: UBB, IBB: IBB, HBP: HBP, SF: SF))"))
        
        return dict
    }
    
}
