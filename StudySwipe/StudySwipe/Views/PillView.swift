//
//  PillView.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/18/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class PillView: UIView {
    
    var color: UIColor {
        didSet { backgroundColor = color }
    }
    var text: String? {
        didSet { textLabel.text = text }
    }
    
    var textColor: UIColor = .white {
        didSet { textLabel.textColor = textColor }
    }
    
    private var textLabel: UILabel

    init(frame: CGRect = .zero, color: UIColor = .clear, text: String? = nil) {
        self.color = color
        
        self.text = text
        textLabel = UILabel()
        textLabel.textColor = textColor
        textLabel.textAlignment = .center
        textLabel.text = text
        
        super.init(frame: frame)
        
        textLabel.constrainToFill(self, top: 4, bottom: 4, leading: 4, trailing: 4)
        backgroundColor = color
        layer.cornerRadius = (textLabel.font.lineHeight + 8) / 2
        
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
