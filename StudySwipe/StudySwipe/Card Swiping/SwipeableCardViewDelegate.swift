//
//  SwipeableCardViewDelegate.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

protocol SwipeableCardViewDelegate: class {
    
    func didSelect(card: SwipeableCard, atIndex index: Int)
    
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection)
}

extension SwipeableCardViewDelegate {
    func didSelect(card: SwipeableCard, atIndex index: Int) {
        return
    }
    
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection) {
        return
    }
}
