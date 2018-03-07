//
//  Player.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/1/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct Player: Decodable {
    
    let id: Int
    let name: Name
    let battingPosition: BattingPosition
    let throwingPosition: ThrowingPosition
    let teamId: Int
    let birthInfo: BirthInfo
    let height: UInt8
    let weight: Int
    let position: Position
    let number: UInt8
    let headshot: URL
    let isPitcher: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case id = "PlayerID"
        case battingPosition = "Bats"
        case throwingPosition = "Throws"
        case teamId = "TeamID"
        case height = "Height"
        case weight = "Weight"
        case position = "Position"
        case number = "Number"
        case headshot = "HeadShotURL"
        case isPitcher = "IsPitcher"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Simple Data Points
        id = try values.decode(Int.self, forKey: .id)
        teamId = try values.decode(Int.self, forKey: .teamId)
        height = try values.decode(UInt8.self, forKey: .height)
        weight = try values.decode(Int.self, forKey: .weight)
        number = try values.decode(UInt8.self, forKey: .number)
        headshot = try values.decode(URL.self, forKey: .headshot)
        isPitcher = try values.decode(Bool.self, forKey: .isPitcher)
        
        // Position Enum
        let rawPosition = try values.decode(UInt8.self, forKey: .position)
        position = Position(rawValue: rawPosition) ?? .Unknown
        
        // Batting and Throwing Position Enums
        let rawBattingPosition = try values.decode(UInt8.self, forKey: .battingPosition)
        battingPosition = BattingPosition(rawValue: rawBattingPosition) ?? BattingPosition.Unknown
        let rawThrowingPosition = try values.decode(UInt8.self, forKey: .throwingPosition)
        throwingPosition = ThrowingPosition(rawValue: rawThrowingPosition) ?? ThrowingPosition.Unknown
        
        
        
        // Name Struct
        let nameValues = try decoder.container(keyedBy: Name.CodingKeys.self)
        
        let full = try nameValues.decode(String.self, forKey: .full)
        let formal = try nameValues.decode(String.self, forKey: .formal)
        let last = try nameValues.decode(String.self, forKey: .last)
        let first = try nameValues.decode(String.self, forKey: .first)
        let uses = try nameValues.decode(String.self, forKey: .uses)
        let middle = try nameValues.decode(String?.self, forKey: .middle)
        let firstInitial = try nameValues.decode(String.self, forKey: .firstInitial)
        let lastInitial = try nameValues.decode(String.self, forKey: .lastInitial)
        name = Name(full: full, formal: formal, last: last, first: first, uses: uses, middle: middle, firstInitial: firstInitial, lastInitial: lastInitial)
        
        // Birth Info Struct
        let birthValues = try decoder.container(keyedBy: BirthInfo.CodingKeys.self)
        let dateString = try birthValues.decode(String.self, forKey: .date)
        
        let date = BirthInfo.convertToDate(dateString)
        let city = try birthValues.decode(String.self, forKey: .city)
        let state = try birthValues.decode(String.self, forKey: .state)
        let country = try birthValues.decode(String.self, forKey: .country)
        birthInfo = BirthInfo(date: date, city: city, state: state, country: country)
    }
    
}

