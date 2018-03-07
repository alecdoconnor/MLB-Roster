//
//  StatCalculations.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct StatCalculations {
    
    static func hits(B1: Int, B2: Int, B3: Int, HR: Int) -> Int {
        return B1 + B2 + B3 + HR
    }
    
    static func walks(UBB: Int, IBB: Int) -> Int {
        return UBB + IBB
    }
    
    static func AVG(B1: Int, B2: Int, B3: Int, HR: Int, AB: Int) -> Double {
        guard AB > 0 else { return 0 }
        return roundToThreePoints(Double(B1 + B2 + B3 + HR) / Double(AB))
    }
    
    static func OBP(B1: Int, B2: Int, B3: Int, HR: Int, AB: Int, UBB: Int, IBB: Int, HBP: Int, SF: Int) -> Double {
        guard (AB + UBB + IBB + HBP + SF) > 0 else { return 0 }
        return roundToThreePoints(Double(B1 + B2 + B3 + HR + UBB + IBB + HBP) / Double(AB + UBB + IBB + HBP + SF))
    }
    
    static func SLG(B1: Int, B2: Int, B3: Int, HR: Int, AB: Int) -> Double {
        guard AB > 0 else { return 0 }
        return roundToThreePoints(Double(B1 + 2*B2 + 3*B3 + 4*HR) / Double(AB))
    }
    
    static func OPS(B1: Int, B2: Int, B3: Int, HR: Int, AB: Int, UBB: Int, IBB: Int, HBP: Int, SF: Int) -> Double {
        let obp = OBP(B1: B1, B2: B2, B3: B3, HR: HR, AB: AB, UBB: UBB, IBB: IBB, HBP: HBP, SF: SF)
        let slg = SLG(B1: B1, B2: B2, B3: B3, HR: HR, AB: AB)
        return roundToThreePoints(obp + slg)
    }
    
    static func inningsPitched(OUTS: Int) -> Int {
        return ((OUTS / 3) + (OUTS % 3)) / 10
    }
    
    static func ERA(ER: Int, OUTS: Int) -> Double {
        guard OUTS > 0 else { return 0 }
        return roundToThreePoints(Double(ER * 27) / Double(OUTS))
    }
    
    
    static func roundToThreePoints(_ value: Double) -> Double {
        return Double(round(1000*value)/1000)
    }
}
