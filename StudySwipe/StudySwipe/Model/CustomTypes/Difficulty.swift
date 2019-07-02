//
//  Difficulty.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

public enum Difficulty: String, Codable, Any, CaseIterable {
    public var description: String {
        return "\(rawValue)"
    }
    
    case Hard = "Hard"
    case Medium = "Medium"
    case Easy = "Easy"
    case All = "All"
}
