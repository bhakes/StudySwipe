//
//  AppThemeProvider.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/12/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

final class AppThemeProvider: ThemeProvider {
    static let shared: AppThemeProvider = .init()
    
    private var theme: SubscribableValue<AppTheme>
    private var availableThemes: [AppTheme] = [.light, .dark]
    
    var currentTheme: AppTheme {
        get {
            return theme.value
        }
        set {
            setNewTheme(newValue)
            setKeyFor(newValue)
        }
    }
    
    init() {
        // We'll default to the light theme to start with, but
        // this could read directly from UserDefaults to get
        // the user's last theme choice.
        theme = SubscribableValue<AppTheme>(value: .dark)
        loadThemeFromUserDefaults()
    }
    
    private func setNewTheme(_ newTheme: AppTheme) {
        let window = UIApplication.shared.delegate!.window!!
        UIView.transition(
            with: window,
            duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: {
                self.theme.value = newTheme
        },
            completion: nil
        )
    }
    
    func subscribeToChanges(_ object: AnyObject, handler: @escaping (AppTheme) -> Void) {
        theme.subscribe(object, using: handler)
    }
    
    func nextTheme() {
        guard let nextTheme = availableThemes.rotate() else {
            return
        }
        currentTheme = nextTheme
    }
    
    private func loadThemeFromUserDefaults() {
        let defaults = UserDefaults.standard
        let theme = defaults.object(forKey:"Theme") as? String
        if theme == "dark" {
            self.theme = SubscribableValue<AppTheme>(value: .dark)
            self.availableThemes = [.dark, .light]
        } else {
            self.theme = SubscribableValue<AppTheme>(value: .light)
            self.availableThemes = [.light, .dark]
        }
    }
    
    private func setKeyFor(_ appTheme: AppTheme){
        let defaults = UserDefaults.standard
        
        if appTheme == AppTheme.dark {
            defaults.set("dark", forKey: "Theme")
        } else {
            defaults.set("light", forKey: "Theme")
        }
    }
    
    
}

extension Themed where Self: AnyObject {
    var themeProvider: AppThemeProvider {
        return AppThemeProvider.shared
    }
}
