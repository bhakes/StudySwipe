//
//  MasteryBadge.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/25/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation


func loadMasteryUpdatesFromUserDefaults() -> UInt? {
    let defaults = UserDefaults.standard
    let badgeValue = defaults.object(forKey:"MasteryBadge") as? UInt
    if badgeValue == 0 {
        return nil
    } else {
        return badgeValue
    }
}

func setMasteryUpdatesToUserDefaults(_ uint: UInt? = nil) {
    let defaults = UserDefaults.standard
    if let uint = uint {
        defaults.set(uint, forKey: "MasteryBadge")
    } else {
        defaults.set(0, forKey: "MasteryBadge")
    }
    
    
}
