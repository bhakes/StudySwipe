//
//  PillView.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/18/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

/// A class that implements chips in a pill-like 💊 form
class PillView: UIView {
    
    // MARK: - Initializers
    
    /**
     Initializes a new 💊-View with the provided parts and specifications.
     
     - Parameters:
        - frame: The frame size of the 💊-View
        - color: The color of the 💊-View
        - text: The text that will show inside the 💊-View
     
     - Returns: A beautiful, 💊-View,
     custom-built just for you.
     */
    init(frame: CGRect = .zero, color: UIColor = .clear, text: String? = nil) {
        self.color = color
        
        self.text = text
        textLabel = UILabel()
        textLabel.textColor = textColor
        textLabel.textAlignment = .center
        textLabel.text = text
        
        super.init(frame: frame)
        
        textLabel.constrainToFill(self, top: 8, bottom: 8, leading: 12, trailing: 12)
        backgroundColor = color
        layer.cornerRadius = (textLabel.font.lineHeight + 16) / 2
        layer.borderWidth = 2
        layer.borderColor = borderColor.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 2, height: 5)
        
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// The color of the 💊-View
    var color: UIColor {
        didSet { backgroundColor = color }
    }
    
    /// The border color of the 💊-View
    var borderColor: UIColor = .clear {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    
    /// The shadowOpacity of the 💊-View
    var shadowOpacity: Float = 0 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }
    
    /// The text string to display in a label inside the 💊-View
    var text: String? {
        didSet { updateTextLabel() }
    }
    
    /// The textLabel color inside the 💊-View
    var textColor: UIColor = .white {
        didSet { textLabel.textColor = textColor }
    }
    
    /// The textLabel inside the 💊-View
    private var textLabel: UILabel
    
    
    // MARK: - Methods
    
    /**
     Update the text label with the current text and size the text to fit the 💊-View
    
     - Precondition: `text` should have already been set.
     */
    private func updateTextLabel() {
        textLabel.text = text
        textLabel.sizeToFit()
    }
    
}
