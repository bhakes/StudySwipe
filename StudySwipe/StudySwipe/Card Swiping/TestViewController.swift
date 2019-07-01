//
//  TestViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, SwipeableCardViewDelegate, SwipeableCardViewDataSource {
    
    let testQuestion = Question(answer: "Just checking", category: .designPatterns, difficulty: .easy, question: "Is this a test?", track: .iOSDeveloper)
    var cardContainer: SwipeableCardViewContainer!
    var infoBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoBar = UIView()
        infoBar.constrainToSuperView(view, top: 8, leading: 0, trailing: 0, height: 60)
        
        cardContainer = SwipeableCardViewContainer()
        cardContainer.constrainToSuperView(view, bottom: 20 + SwipeableCardViewContainer.verticalInset*2, leading: 20, trailing: 20)
        cardContainer.constrainToSiblingView(infoBar, below: 8)
        
        cardContainer.alpha = 0
        cardContainer.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardContainer.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.cardContainer.alpha = 1
        }
    }
    
    func numberOfCards() -> Int {
        return 20
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCard {
        let card = SwipeableCard()
        card.backgroundColor = .white
        card.fillWithQuestion(testQuestion)
        return card
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
    func didSelect(card: SwipeableCard, atIndex index: Int) {
        return
    }
    
    
    

    
}
