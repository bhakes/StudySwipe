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
    var cellBackgroundColor: UIColor
    var backgroundColor: UIColor
    var textColor: UIColor
    var trackTintColor: UIColor
}

extension AppTheme {
    static let light = AppTheme(
        statusBarStyle: .`default`,
        barBackgroundColor: .lightText,
        barForegroundColor: .accentColor,
        cellBackgroundColor: .lightText,
        backgroundColor: .white,
        textColor: .black,
        trackTintColor: .lightGray.lightened(by: 0.4)
    )
    
    static let dark = AppTheme(
        statusBarStyle: .lightContent,
        barBackgroundColor: .black,
        barForegroundColor: .white,
        cellBackgroundColor: UIColor(white: 0.2, alpha: 1.0),
        backgroundColor: .black,
        textColor: .fadedTextColor,
        trackTintColor: .fadedTextColor
        
    )
}

extension AppTheme: Equatable {
    static func ==(lhs: AppTheme, rhs: AppTheme) -> Bool {
        return lhs.statusBarStyle == rhs.statusBarStyle && lhs.barBackgroundColor == rhs.barBackgroundColor && lhs.barForegroundColor == rhs.barForegroundColor && lhs.backgroundColor == rhs.backgroundColor && lhs.textColor == rhs.textColor
    }
}
