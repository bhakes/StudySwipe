//
//  SwipeableCardViewDelegate.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

protocol SwipeableCardViewDelegate: class {
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardViewContainer, didSelectCard card: SwipeableCard, atIndex index: Int)
    
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection)
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardViewContainer, isEmpty: Bool)
}

extension SwipeableCardViewDelegate {
    func cardViewContainer(_ cardView: SwipeableCardViewContainer, didSelectCard card: SwipeableCard, atIndex index: Int) {
        return
    }
    
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection) {
        return
    }
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardViewContainer, isEmpty: Bool) {
        return
    }
}
