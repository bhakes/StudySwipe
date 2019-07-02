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
    private var startTime = Date()
    
    var dismissButtonTitle = "Quit Test" {
        didSet { updateButtonTitle() }
    }
    
    var coreDataFetchController: CoreDataFetchController?
    var testObservation: InterviewTestObservation?
    var test: InterviewTest? {
        didSet {
            guard let questions = test?.questions else {
                // Handle not having any questions
                // Present an alert?
                return
            }
            self.questions = questions
        }
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
            let alertVC = UIAlertController.informationalAlertController(title: .quitTestAlertTitle, message: .quitTestAlertMessage, dismissTitle: "Dismiss", dismissActionCompletion: dismissTest, withCancel: true)
            present(alertVC, animated: true)
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
        guard let observation = testObservation else { return }
        guard let question = card.question else { return }
        
        let duration = DateInterval(start: startTime, end: Date()).duration
        let response: Response = direction.horizontalPosition == .right ? .correct : .incorrect
        guard let questionID = question.questionID else { fatalError("The Question does not have a questionID")}
        
        _ = coreDataFetchController?.recordQuestionObservation(with: response, for: questionID, with: Int(duration), in: observation)
        
        // Reset timer for the next question
        startTime = Date()
    }
    
    // MARK: Private Methods
    private func setupViews() {
        view.backgroundColor = .white
        
        infoBar = UIView()
        infoBar.constrainToSuperView(view, top: 0, leading: 0, trailing: 0, height: 60)
        
        cardContainer = SwipeableCardViewContainer()
        cardContainer.constrainToSuperView(view, bottom: 20 + SwipeableCardViewContainer.verticalInset*2, leading: 20, trailing: 20)
        cardContainer.constrainToSiblingView(infoBar, below: 24)
        
        cardContainer.alpha = 0
        cardContainer.dataSource = self
        cardContainer.delegate = self
        
        dismissButton = UIButton(type: .system)
        updateButtonTitle()
        dismissButton.setTitleColor(.warningColor, for: .normal)
        dismissButton.addTarget(self, action: #selector(closeTest), for: .touchUpInside)
        dismissButton.constrainToSuperView(infoBar, top: 0, trailing: 20)
        
        startTime = Date()
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
    
    private func dismissTest(action: UIAlertAction! = nil) {
        if testObservation != nil {
            coreDataFetchController?.finishTestAndFinalizeObservation(&testObservation!)
        }
        dismiss(animated: true)
    }
    
}

extension String {
    fileprivate static let quitTestAlertTitle = "Are you sure you want to quit?"
    fileprivate static let quitTestAlertMessage = "Your data thus far will be saved, you will lose out on the remaining questions."
}
