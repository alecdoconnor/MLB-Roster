//
//  AlertFactory.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

struct AlertFactory {
    
    static func genericError() -> UIAlertController {
        let alert = UIAlertController(title: "There was a problem performing that action", message: "Well this is awkward. Go ahead and give that another try.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    static func customError(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
}
