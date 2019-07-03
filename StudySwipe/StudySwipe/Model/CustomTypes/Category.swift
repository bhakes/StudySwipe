//
//  Category.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

public enum Category: String, Codable, CaseIterable, ColorIconTitleProviding {
    
    
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
    
    // MARK: Color Icon Title Providing
    func color() -> UIColor {
        switch self {
        case .Swift:
            return .swift
        default:
            return Category.getDefaultColor(for: self)
        }
    }
    func icon() -> UIImage {
        switch self {
        case .Swift:
            return UIImage(named: "swift")!
        default:
            return UIImage(named: "literature")!
        }
    }
    
    func title() -> String {
        return self.description
    }
    
    
    // Some helpers for cycling through the default colors.
    static let defaultColors: [UIColor] = [.categoryDefault1,
                                        .categoryDefault2,
                                        .categoryDefault3,
                                        .categoryDefault4,
                                        .categoryDefault5]
    
    private static func getDefaultColor(for category: Category) -> UIColor {
        let index = Category.allCases.firstIndex(of: category)!
        let color = defaultColors[index % defaultColors.count]
        
        return color
    }
}
