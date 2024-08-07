//
//  Difficulty.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

public enum Difficulty: String, Codable, Any, CaseIterable, ColorIconTitleProviding {
    
    public var description: String {
        return "\(rawValue)"
    }
    case All = "All"
    case Easy = "Easy"
    case Medium = "Medium"
    case Hard = "Hard"
    
    
    // MARK: Color Icon Title Providing
    func color() -> UIColor {
        switch self {
        case .Easy:
            return .categoryDefault3
        case .Medium:
            return .categoryDefault5
        case .Hard:
            return .categoryDefault1
        case .All:
            return .categoryDefault2
        }
    }
    func icon() -> UIImage {
        let name: String
        switch self {
        case .Easy:
            name = "easy"
        case .Medium:
            name = "medium"
        case .Hard:
            name = "hard"
        case .All:
            name = "all-difficulty"
        }
        return UIImage(named: name) ?? UIImage(named: "cancel")!
    }
    
    func title() -> String {
        return self.description
    }
    
}
