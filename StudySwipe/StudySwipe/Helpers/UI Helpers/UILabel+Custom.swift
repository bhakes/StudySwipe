//
//  UILabel+Custom.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/27/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

extension UILabel {
    enum LabelType {
        case title, header1, header2, body
    }
    
    static func label(for labelType: LabelType, with string: String? = nil) -> DMCLabel {
        let label = DMCLabel()
        label.text = string
        
        switch labelType {
            
        case .title:
            label.font = UIFont.boldSystemFont(ofSize: 48)
        case .header1:
            label.font = UIFont.boldSystemFont(ofSize: 36)
        case .header2:
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = .fadedTextColor
        case .body:
            label.font = UIFont.systemFont(ofSize: 17)
            label.textColor = .fadedTextColor
        }
        
        return label
    }
}
