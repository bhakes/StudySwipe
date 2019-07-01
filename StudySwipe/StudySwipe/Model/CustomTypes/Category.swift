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
    case memoryManagement = "MemoryManagement"
    case uiKit = "UIKit"
    case designPatterns = "DesignPatterns"
    case debugging = "Debugging"
    case foundation = "Foundation"
    case oop = "OOP"
    case objectivec = "Objective-C"
}
