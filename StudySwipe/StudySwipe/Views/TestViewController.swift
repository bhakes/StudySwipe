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
    var closeButtonAction: (() -> Void)?
    private var dismissButton: UIButton!
    
    var dismissButtonTitle = "Quit Test" {
        didSet { updateButtonTitle() }
    }
    
    var questions: [Question] = [] {
        didSet {
            guard isViewLoaded else { return }
            cardContainer.reloadData()
        }
    }
    
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
    
    @objc func closeTest() {
        if let action = closeButtonAction {
            action()
        } else {
            dismiss(animated: true)
        }
    }
    
    // MARK: - Swipable Card View Data Source
    func numberOfCards() -> Int {
        return questions.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCard {
        let card = SwipeableCard()
        card.backgroundColor = .white
        
        let question = questions[index]
        card.question = question
        return card
    }
    
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection) {
        print("The user swiped: \(direction.horizontalPosition.description())")
    }
    
    // MARK: Private Methods
    private func setupViews() {
        infoBar = UIView()
        infoBar.constrainToSuperView(view, top: 0, leading: 0, trailing: 0, height: 60)
        
        cardContainer = SwipeableCardViewContainer()
        cardContainer.constrainToSuperView(view, bottom: 20 + SwipeableCardViewContainer.verticalInset*2, leading: 20, trailing: 20)
        cardContainer.constrainToSiblingView(infoBar, below: 8)
        
        cardContainer.alpha = 0
        cardContainer.dataSource = self
        cardContainer.delegate = self
        
        dismissButton = UIButton(type: .system)
        updateButtonTitle()
        dismissButton.setTitleColor(.warningColor, for: .normal)
        dismissButton.addTarget(self, action: #selector(closeTest), for: .touchUpInside)
        dismissButton.constrainToSuperView(infoBar, top: 0, trailing: 20)
        
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
    
    private func updateButtonTitle() {
        guard isViewLoaded else { return }
        dismissButton.setTitle(dismissButtonTitle, for: .normal)
    }
    
}
