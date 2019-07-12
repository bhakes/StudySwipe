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
    case Other = "Other"
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
        let name: String
        switch self {
        case .Concurrency:
            name = "concurrency"
        case .CoreData:
            name = "core-data"
        case .Notifications:
            name = "notifications"
        case .Swift:
            name = "swift"
        case .DesignPatterns:
            name = "design-patterns"
        case .MemoryManagement:
            name = "memory-management"
        case .Oop:
            name = "oop"
        case .Objectivec:
            name = "objective-c"
        case .Debugging:
            name = "debugging"
        case .UIKit:
            name = "uikit"
        case .Foundation:
            name = "foundation"
        case .All:
            name = "all-category"
        case .Other:
            name = "literature"
//        default:
//            name = "literature"
        }
        return UIImage(named: name) ?? UIImage(named: "cancel")!
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
        let index = Category.nonEmptyCategories.firstIndex(of: category)!
        let color = defaultColors[index % defaultColors.count]
        
        return color
    }
    
    static private var nonEmptySet: Set<Category> = {
        return Set(nonEmptyCategories)
    }()
    static private(set) var nonEmptyCategories: [Category] = {
        if let savedData = UserDefaults.standard.object(forKey: "nonEmptyCategories") as? Data,
            let categories = try? JSONDecoder().decode([Category].self, from: savedData) {
            return  categories
        } else {
            return [.All]
        }
    }()
    
    static func resetNonEmptyCategories() {
        nonEmptyCategories.removeAll()
        nonEmptySet.removeAll()
        nonEmptySet.insert(.All)
        nonEmptyCategories.append(.All)
        saveNonEmpties()
    }
    
    static func addNonEmptyCategory(_ category: Category) {
        if !nonEmptySet.contains(category) {
            nonEmptySet.insert(category)
            nonEmptyCategories.append(category)
            saveNonEmpties()
        }
    }
    
    static private func saveNonEmpties() {
        if let data = try? JSONEncoder().encode(nonEmptyCategories) {
            UserDefaults.standard.set(data, forKey: "nonEmptyCategories")
        }
    }
}
