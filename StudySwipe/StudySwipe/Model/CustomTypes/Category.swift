//
//  Category.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

public enum Category: String, Codable {
    
    public var description: String {
        return "\(rawValue)"
    }
    
    case CoreData = "CoreData"
    case Swift = "Swift"
    case Concurrency = "Concurrency"
    case Notifications = "Notifications"
    case MemoryManagement = "Memory Management"
    case UIKit = "UIKit"
    case DesignPatterns = "Design Patterns"
    case Debugging = "Debugging"
    case Foundation = "Foundation"
    case Oop = "OOP"
    case Objectivec = "Objective-C"
    case All = "All"
}
