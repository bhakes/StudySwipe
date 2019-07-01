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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardContainer = SwipeableCardViewContainer()
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardContainer)
        
        NSLayoutConstraint.activate([
            cardContainer.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                  constant: -64),
            cardContainer.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                 constant: -40),
            cardContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
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