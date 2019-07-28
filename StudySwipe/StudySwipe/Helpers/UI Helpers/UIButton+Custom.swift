//
//  UIButton+Custom.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/27/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

extension UIButton {
    
    enum CustomButtonType {
        case normal, warning
    }
    
    static func button(for buttonType: CustomButtonType, with title: String? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 8
        
        switch buttonType {
        
        case .normal:
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .accentColor
        case .warning:
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .warningColor
        }
        
        return button
    }
}
