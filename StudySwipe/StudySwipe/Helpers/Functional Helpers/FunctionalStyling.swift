//
//  FunctionalStyling.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/11/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit
import Foundation

enum Theme {
    case light
    case dark
}

enum ColorType {
    case backgroundColor
    case tintColor
    case barTintColor
    case textColor
    case grayTextColor
    case tabBarTintColor
    case trackBarTintColor
}

final class ThemeController {
    static let shared = ThemeController()
    private init () {}
    
    var currentTheme: Theme = .light
    
}

extension Theme {
    func colorFor(_ colorType: ColorType) -> UIColor {
        switch self {
        case .light:
            switch colorType {
            case .backgroundColor:
                return .white
            case .tintColor:
                return .white
            case .barTintColor:
                return .fadedTextColor
            case .textColor:
                return .black
            case .grayTextColor:
                return .fadedTextColor
            case .tabBarTintColor:
                return .accentColor
            case .trackBarTintColor:
                return .groupTableViewBackground
            }
        case .dark:
            switch colorType {
            case .backgroundColor:
                return .testBackground
            case .tintColor:
                return .testBackground
            case .barTintColor:
                return .testBackground
            case .textColor:
                return .white
            case .grayTextColor:
                return .fadedTextColor
            case .tabBarTintColor:
                return .white
            case .trackBarTintColor:
                return .fadedTextColor
            }
        }
    }
}

//func darkModeConformingStyle<V: UIView>(_ view: V) -> Void {
//    
//    let theme = ThemeController.shared.currentTheme
//    view.backgroundColor = theme.colorFor(.backgroundColor)
//    view.tintColor = theme.colorFor(.tintColor)
//    
//}
//
//func darkModeConformingStyle<N: UINavigationController>(_ navController: N) -> Void {
//    
//    let theme = ThemeController.shared.currentTheme
//    navController.navigationBar.backgroundColor = theme.colorFor(.backgroundColor)
//    navController.navigationBar.tintColor = theme.colorFor(.tintColor)
//    navController.navigationBar.barTintColor = theme.colorFor(.barTintColor)
//    
//}
//
//
//func darkModeConformingStyle<L: UILabel>(_ label: L) -> Void {
//    
//    let theme = ThemeController.shared.currentTheme
//    label.tintColor = theme.colorFor(.tintColor)
//    label.textColor = theme.colorFor(.textColor)
//    
//}
//
//func darkModeConformingStyle<T: UITabBarController>(_ tabBarController: T) -> Void {
//    
//    let theme = ThemeController.shared.currentTheme
//    tabBarController.view.backgroundColor = theme.colorFor(.backgroundColor)
//    tabBarController.tabBar.tintColor = theme.colorFor(.tabBarTintColor)
//    tabBarController.tabBar.barTintColor = theme.colorFor(.tintColor)
//    
//    
//}
//
//func darkModeConformingStyle<S: UISegmentedControl>(_ sc: S) -> Void {
//    sc.tintColor = .accentColor
//}
//
//let grayDarkStyleConformingLabel: (UILabel) -> Void = darkModeConformingStyle <> {
//    
//    let theme = ThemeController.shared.currentTheme
//    $0.textColor = theme.colorFor(.textColor)
//    
//}
//
//let grayDarkStyleConformingView: (UIView) -> Void = darkModeConformingStyle <> {
//    
//    let theme = ThemeController.shared.currentTheme
//    $0.tintColor = theme.colorFor(.tintColor)
//    
//}
//
//func whiteDarkStyleConformingProgressView <P: UIProgressView>(_ progressView: P) -> Void  {
//    let theme = ThemeController.shared.currentTheme
//    progressView.trackTintColor = theme.colorFor(.trackBarTintColor)
//}
//
//
//func alwaysDarkStyle<V: UIView>(_ view: V) -> Void {
//    view.backgroundColor = .testBackground
//}
