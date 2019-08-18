//
//  SwipeableCard.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

/// A 👋 Swipeable Card that inherits from `SwipeableView`
class SwipeableCard: SwipeableView {
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init from coder not implemented")
    }
    
    
    /**
     Initializes a new 👋 Swipeable Card that inherits from `SwipeableView`.
     
     - Parameters:
     - frame: The frame of the new 👋 Swipeable Card
     
     - Returns: A beautiful, 👋 Swipeable Card,
     custom-built just for you.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 24
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 4, height: 10)
    }
}
