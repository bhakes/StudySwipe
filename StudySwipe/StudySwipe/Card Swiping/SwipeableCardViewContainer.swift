//
//  SwipeableCardViewContainer.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class SwipeableCardViewContainer: UIView, SwipeableViewDelegate {
    
    static let distanceScale: CGFloat = 0.05
    
    static let verticalInset: CGFloat = 12.0
    
    static var preferredWidth: CGFloat = 300.0
    
    var dataSource: SwipeableCardViewDataSource? {
        didSet {
            reloadData()
        }
    }
    
    var delegate: SwipeableCardViewDelegate?
    
    private var cardViews: [SwipeableCard] = []
    
    private var visibleCardViews: [SwipeableCard] {
        return subviews as? [SwipeableCard] ?? []
    }
    
    fileprivate var remainingCards: Int = 0
    
    static let numberOfVisibleCards: Int = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Reloads the data used to layout card views in the
    /// card stack. Removes all existing card views and
    /// calls the dataSource to layout new card views.
    func reloadData() {
        removeAllCardViews()
//        SwipeableCardViewContainer.preferredWidth = bounds.width - 24
        guard let dataSource = dataSource else {
            return
        }
        
        let numberOfCards = dataSource.numberOfCards()
        remainingCards = numberOfCards
        
        for index in 0..<min(numberOfCards, SwipeableCardViewContainer.numberOfVisibleCards) {
            addCardView(cardView: dataSource.card(forItemAtIndex: index), atIndex: index)
        }
        
        if let emptyView = dataSource.viewForEmptyCards() {
            emptyView.constrainToFill(self)
        }
        
        setNeedsLayout()
    }
    
    private func addCardView(cardView: SwipeableCard, atIndex index: Int) {
        cardView.delegate = self
        cardView.frame = calculateFrame()
        cardView.transform = transform(forCardView: cardView, atIndex: index)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingCards -= 1
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCardViews {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    private func calculateFrame() -> CGRect {
        let x = bounds.origin.x
        let y = bounds.origin.y + 2 * SwipeableCardViewContainer.verticalInset
        let width = bounds.size.width
        let height = bounds.size.height - 2 * SwipeableCardViewContainer.verticalInset
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func transform(forCardView cardView: SwipeableCard, atIndex index: Int) -> CGAffineTransform {
        let verticalInset = CGFloat(index) * SwipeableCardViewContainer.verticalInset * 2
        let scale = 1 - (SwipeableCardViewContainer.distanceScale * CGFloat(index))
        
        return CGAffineTransform.identity.translatedBy(x: 0, y: -verticalInset).scaledBy(x: scale, y: scale)
    }
    
}

// MARK: - SwipeableViewDelegate

extension SwipeableCardViewContainer {
    
    func didTap(view: SwipeableView) {
        let flipDuration = 0.5
        if let cardView = view as? QuestionCard,
            let index = cardViews.firstIndex(of: cardView) {
            delegate?.cardViewContainer(self, didSelectCard: cardView, atIndex: index)
            
            UIView.animate(withDuration: flipDuration/2, delay: 0, options: [.curveEaseIn], animations: {
                cardView.transform = cardView.transform.scaledBy(x: 0.001, y: 0.96)
            }) { _ in
                cardView.handleTap()
                UIView.animate(withDuration: flipDuration/2, delay: 0, options: [.curveEaseOut], animations: {
                    cardView.transform = self.transform(forCardView: cardView, atIndex: 0)
                })
            }
            
        }
    }
    
    func didBeginSwipe(onView view: SwipeableView) {
        // React to Swipe Began?
    }
    
    func didEndSwipe(onView view: SwipeableView, in direction: SwipeDirection) {
        guard let dataSource = dataSource else {
            return
        }
        
        if let card = view as? SwipeableCard {
            delegate?.card(card, didCommitSwipeInDirection: direction)
        }
        
        // Remove swiped card
        view.removeFromSuperview()
        if visibleCardViews.count == 0 {
            delegate?.cardViewContainer(self, isEmpty: true)
        }
        
        // Only add a new card if there are cards remaining
        if remainingCards > 0 {
            
            // Calculate new card's index
            let newIndex = dataSource.numberOfCards() - remainingCards
            
            // Add new card as Subview
            addCardView(cardView: dataSource.card(forItemAtIndex: newIndex), atIndex: 2)
            
        }
        
        // Update all existing card's transform based on new indexes, animate transform
        // to reveal new card from underneath the stack of existing cards.
        for (cardIndex, cardView) in visibleCardViews.reversed().enumerated() {
            UIView.animate(withDuration: 0.2, animations: {
                cardView.transform = self.transform(forCardView: cardView, atIndex: cardIndex)
                self.layoutIfNeeded()
            })
        }
    }
    
}

