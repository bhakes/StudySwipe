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
    
    case Easy = "Easy"
    case Medium = "Medium"
    case Hard = "Hard"
    case All = "All"
    
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
        switch self {
        case .Easy:
            return UIImage(named: "easy")!
        case .Medium:
            return UIImage(named: "medium")!
        case .Hard:
            return UIImage(named: "hard")!
        case .All:
            return UIImage(named: "all-difficulty")!
        }
    }
    
    func title() -> String {
        return self.description
    }
    
}
