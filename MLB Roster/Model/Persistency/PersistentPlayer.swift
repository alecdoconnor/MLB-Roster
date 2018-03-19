//
//  PersistentPlayer.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation
import CoreData

extension PersistentPlayer {
    
    convenience init(player: Player, context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.battingPosition = Int16(player.battingPosition.rawValue)
        self.birthCity = player.birthInfo.city
        self.birthCountry = player.birthInfo.country
        self.birthDate = player.birthInfo.date
        self.birthState = player.birthInfo.state
        self.firstInitial = player.name.firstInitial
        self.firstName = player.name.first
        self.formalName = player.name.formal
        self.fullName = player.name.full
        self.headshotURL = player.headshot
        self.height = Int16(player.height)
        self.id = Int32(player.id)
        self.isPitcher = player.isPitcher
        self.lastInitial = player.name.lastInitial
        self.lastName = player.name.last
        self.middleName = player.name.middle
        self.number = Int16(player.number)
        self.position = Int16(player.position.rawValue)
        self.positionString = player.position.stringValue()
        self.teamId = Int16(player.teamId)
        self.throwingPosition = Int16(player.throwingPosition.rawValue)
        self.usesName = player.name.uses
        self.weight = Int16(player.weight)
        
        // Save a team relationship, if it exists
        // This should occur fast enough to perform it in the initializer
        let teamFetchRequest: NSFetchRequest<PersistentTeam> = PersistentTeam.fetchRequest()
        teamFetchRequest.predicate = NSPredicate(format: "id == %d", Int(teamId))
        teamFetchRequest.fetchLimit = 1
        
        do {
            let fetchResults = try context.fetch(teamFetchRequest)
            if fetchResults.count > 0 {
                self.team = (fetchResults.first)!
            }
        } catch {
            print("Unable to satisfy Team Fetch Request for player: \(self.fullName ?? "nil")-\(self.id)")
        }
        
    }
    
    func returnPlayer() -> Player {
        // Initialize stored struct/enum-based properties
        let battingPosition = BattingPosition(rawValue: UInt8(self.battingPosition)) ?? .Unknown
        let birthInfo = BirthInfo(date: self.birthDate ?? Date(timeIntervalSince1970: 0.0),
                                  city: self.birthCity ?? "",
                                  state: self.birthState ?? "",
                                  country: self.birthCountry ?? "")
        let name = Name(full: self.fullName ?? "",
                        formal: self.formalName ?? "",
                        last: self.lastName ?? "",
                        first: self.firstName ?? "",
                        uses: self.usesName ?? "",
                        middle: self.middleName ?? "",
                        firstInitial: self.firstInitial ?? "",
                        lastInitial: self.lastInitial ?? "")
        let position = Position(rawValue: UInt8(self.position)) ?? .Unknown
        let throwingPosition = ThrowingPosition(rawValue: UInt8(self.throwingPosition)) ?? .Unknown
        
        // Return player object from properties
        return Player(id: Int(id),
                        name: name,
                        battingPosition: battingPosition,
                        throwingPosition: throwingPosition,
                        teamId: Int(teamId),
                        birthInfo: birthInfo,
                        height: UInt8(height),
                        weight: Int(weight),
                        position: position,
                        number: UInt8(number),
                        headshot: (headshotURL)!,
                        isPitcher: isPitcher)
    }
    
}
