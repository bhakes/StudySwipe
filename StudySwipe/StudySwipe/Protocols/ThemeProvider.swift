//
//  ThemeProvider.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/9/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import UIKit

/// Describes a type that holds a current `Theme` and allows
/// an object to be notified when the theme is changed.
protocol ThemeProvider {
    /// Placeholder for the theme type that the app will actually use
    associatedtype Theme
    
    /// The current theme that is active
    var currentTheme: Theme { get }
    
    /// Subscribe to be notified when the theme changes. Handler will be
    /// removed from subscription when `object` is deallocated.
    func subscribeToChanges(_ object: AnyObject, handler: @escaping (Theme) -> Void)
}

