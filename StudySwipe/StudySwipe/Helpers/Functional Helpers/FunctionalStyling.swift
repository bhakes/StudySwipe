//
//  FunctionalStyling.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/11/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit
import Foundation

enum Themes {
    case light
    case dark
}

final class ThemeController {
    static let shared = ThemeController()
    private init () {}
    
    var currentTheme: Themes = .light
}

func autolayoutStyle<V: UIView>(_ view: V) -> Void {
    view.translatesAutoresizingMaskIntoConstraints = false
}

func darkModeConformingStyle<V: UIView>(_ view: V) -> Void {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        view.backgroundColor = .white
        view.tintColor = UIColor(hex: "#33333B")!
    case .dark:
        view.backgroundColor = UIColor(hex: "#33333B")!
        view.tintColor = .white
    }
    
}

func darkModeConformingStyle<N: UINavigationController>(_ navController: N) -> Void {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        navController.navigationBar.backgroundColor = .white
        navController.navigationBar.tintColor = UIColor(hex: "#33333B")!
        navController.navigationBar.barTintColor = UIColor(hex: "#33333B")!
    case .dark:
        navController.navigationBar.backgroundColor = UIColor(hex: "#33333B")!
        navController.navigationBar.tintColor = .white
        navController.navigationBar.barTintColor = .white
    }
    
}


func darkModeConformingStyle<L: UILabel>(_ label: L) -> Void {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        label.tintColor = .white
        label.textColor = .black
    case .dark:
        label.tintColor = UIColor(hex: "#33333B")!
        label.textColor = .white
    }
    
}

func darkModeConformingStyle<T: UITabBarController>(_ tabBarController: T) -> Void {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        tabBarController.view.backgroundColor = .white
        tabBarController.tabBar.tintColor = .accentColor
        tabBarController.tabBar.barTintColor = .white
    case .dark:
        tabBarController.view.backgroundColor = UIColor(hex: "#33333B")!
        tabBarController.tabBar.barTintColor = UIColor(hex: "#33333B")!
        tabBarController.tabBar.tintColor = .white
    }
    
}

func darkModeConformingStyle<S: UISegmentedControl>(_ sc: S) -> Void {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        sc.tintColor = .accentColor
    case .dark:
        sc.tintColor = .accentColor
    }
    
}

let grayDarkStyleConformingLabel: (UILabel) -> Void = darkModeConformingStyle <> {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        $0.textColor = .fadedTextColor
    case .dark:
        $0.textColor = .white
    }
}

let grayDarkStyleConformingView: (UIView) -> Void = darkModeConformingStyle <> {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        $0.tintColor = .fadedTextColor
    case .dark:
        $0.tintColor = .white
    }
}

func whiteDarkStyleConformingProgressView <P: UIProgressView>(_ progressView: P) -> Void  {
    
    switch ThemeController.shared.currentTheme {
    case .light:
        progressView.trackTintColor = UIColor.init(white: 0.92, alpha: 1)
    case .dark:
        progressView.trackTintColor = .fadedTextColor
    }
}


func alwaysDarkStyle<V: UIView>(_ view: V) -> Void {
    view.backgroundColor = .testBackground
}

