//
//  TestViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit
import CoreData

class TestViewController: UIViewController, SwipeableCardViewDelegate, SwipeableCardViewDataSource {
    
    var cardContainer: SwipeableCardViewContainer!
    var infoBar: UIView!
    
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadQuestions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardContainer.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.cardContainer.alpha = 1
        }
    }
    
    func numberOfCards() -> Int {
        return questions.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCard {
        let card = SwipeableCard()
        card.backgroundColor = .white
        
        let question = questions[index]
        card.fillWithQuestion(question)
        return card
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
    func didSelect(card: SwipeableCard, atIndex index: Int) {
        return
    }
    
    
    private func setupViews() {
        infoBar = UIView()
        infoBar.constrainToSuperView(view, top: 8, leading: 0, trailing: 0, height: 60)
        
        cardContainer = SwipeableCardViewContainer()
        cardContainer.constrainToSuperView(view, bottom: 20 + SwipeableCardViewContainer.verticalInset*2, leading: 20, trailing: 20)
        cardContainer.constrainToSiblingView(infoBar, below: 8)
        
        cardContainer.alpha = 0
        cardContainer.dataSource = self
        
    }

    private func loadQuestions() {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "question", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        moc.performAndWait {
            do {
                questions = try moc.fetch(fetchRequest)
            } catch {
                print("Error loading questions: \(error)")
            }
        }
    }
    
}
