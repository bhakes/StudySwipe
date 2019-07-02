//
//  Track.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

public enum Track: String, Codable {
    
    public var description: String {
        return "\(rawValue)"
    }
    
    case iOSDeveloper = "iOSDeveloper"
    case WebDeveloper = "webDeveloper"
    case ProductManager = "productManager"
    case All = "All"
}
