//
//  BirthInfo.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/1/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct BirthInfo: Decodable {
    
    var date: Date
    var city: String
    var state: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        
        case date = "BirthDate"
        case city = "BirthCity"
        case state = "BirthState"
        case country = "BirthCountry"
        
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .state)
        country = try values.decode(String.self, forKey: .country)
        
        let dateString = try values.decode(String.self, forKey: .date)
        date = BirthInfo.convertToDate(dateString)
    }
    
    init(date: Date, city: String, state: String, country: String) {
        // Required to be recreated since another initializer was provided for struct
        self.date = date
        self.city = city
        self.state = state
        self.country = country
    }
    
}

extension BirthInfo {
    static func convertToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DDThh-mm-ss"
        return dateFormatter.date(from: dateString) ?? Date(timeIntervalSince1970: 0)
    }
}
