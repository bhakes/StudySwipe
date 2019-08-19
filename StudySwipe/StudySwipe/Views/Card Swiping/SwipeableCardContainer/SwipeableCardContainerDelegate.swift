//
//  SwipeableCardViewDelegate.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

protocol SwipeableCardContainerDelegate: class {
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardContainer, didSelectCard card: SwipeableCard, atIndex index: Int)
    
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection)
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardContainer, isEmpty: Bool)
}

extension SwipeableCardContainerDelegate {
    func cardViewContainer(_ cardView: SwipeableCardContainer, didSelectCard card: SwipeableCard, atIndex index: Int) {
        return
    }
    
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection) {
        return
    }
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardContainer, isEmpty: Bool) {
        return
    }
}
