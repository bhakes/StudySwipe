//
//  Category.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

public enum Category: String, Codable {
    case coreData = "CoreData"
    case swift = "Swift"
    case concurrency = "Concurrency"
    case notifications = "Notifications"
    case memoryManagement = "Memory Management"
    case uiKit = "UIKit"
    case designPatterns = "Design Patterns"
    case debugging = "Debugging"
    case foundation = "Foundation"
    case oop = "OOP"
    case objectivec = "Objective-C"
}
