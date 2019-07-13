//
//  DarkModeConformingViews.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/13/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import UIKit

class DMCView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTheming()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DMCView: Themed {
    func applyTheme(_ theme: AppTheme) {
        backgroundColor = theme.backgroundColor
    
    }
}


class DMCLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTheming()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DMCLabel: Themed {
    func applyTheme(_ theme: AppTheme) {
        self.textColor = theme.textColor
        
    }
}


class DMCTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheming()
    }
}

extension DMCTabBarController: Themed {
    func applyTheme(_ theme: AppTheme) {
        tabBar.barTintColor = theme.barBackgroundColor
        tabBar.tintColor = theme.barForegroundColor
        
    }
}
