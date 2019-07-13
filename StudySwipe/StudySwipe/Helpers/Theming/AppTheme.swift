//
//  AppTheme.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/12/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

struct AppTheme {
    var statusBarStyle: UIStatusBarStyle
    var barBackgroundColor: UIColor
    var barForegroundColor: UIColor
    var backgroundColor: UIColor
    var textColor: UIColor
}

extension AppTheme {
    static let light = AppTheme(
        statusBarStyle: .`default`,
        barBackgroundColor: .white,
        barForegroundColor: .black,
        backgroundColor: UIColor(white: 0.9, alpha: 1),
        textColor: .darkText
    )
    
    static let dark = AppTheme(
        statusBarStyle: .lightContent,
        barBackgroundColor: UIColor(white: 0, alpha: 1),
        barForegroundColor: .white,
        backgroundColor: UIColor(white: 0.2, alpha: 1),
        textColor: .lightText
    )
}

extension AppTheme: Equatable {
    static func ==(lhs: AppTheme, rhs: AppTheme) -> Bool {
        return lhs.statusBarStyle == rhs.statusBarStyle && lhs.barBackgroundColor == rhs.barBackgroundColor && lhs.barForegroundColor == rhs.barForegroundColor && lhs.backgroundColor == rhs.backgroundColor && lhs.textColor == rhs.textColor
    }
}
