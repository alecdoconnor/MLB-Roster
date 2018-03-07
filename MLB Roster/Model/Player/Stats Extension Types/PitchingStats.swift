//
//  PitchingStats.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct PitchingStats: Decodable {
    
    let playerId: Int
    let yearId: Int
    let levelId: UInt8
    let teamId: Int
    let team: Team
    let level: Level
    
    let G: Int
    let AB: Int
    let B1: Int
    let B2: Int
    let B3: Int
    let HR: Int
    let UBB: Int
    let HBP: Int
    let SO: Int
    let IBB: Int
    let SH: Int
    let SF: Int
    let PA: Int
    let R: Int
    
    // Pitching Specific
    let OUTS: Int
    let ER: Int
    let GS: Int
    let GF: Int
    let CG: Int
    let SHO: Int
    let W: Int
    let L: Int
    let SV: Int
    
    enum CodingKeys: String, CodingKey {
        
        // Default keys
        case G, AB, B1, B2, B3, HR, UBB, HBP, SO, IBB, SH, SF, PA, R
        case OUTS, ER, GS, GF, CG, SHO, W, L, SV
        
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
        dict.append(("Games Started", "\(GS)"))
        dict.append(("Wins-Losses-Saves", "\(W)-\(L)-\(SV)"))
        dict.append(("Innings Pitched", "\(StatCalculations.inningsPitched(OUTS: OUTS))"))
        dict.append(("Hits", "\(StatCalculations.hits(B1: B1, B2: B2, B3: B3, HR: HR))"))
        dict.append(("Strike Outs", "\(SO)"))
        dict.append(("Walks", "\(StatCalculations.walks(UBB: UBB, IBB: IBB))"))
        dict.append(("ERA", "\(StatCalculations.ERA(ER: ER, OUTS: OUTS))"))
        
        return dict
    }
    
}
