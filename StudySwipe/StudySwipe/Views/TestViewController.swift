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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Properties
    private var dismissButton: UIButton!
    private var titleLabel: UILabel!
    private var startTime = Date()
    private var needsWorkImageView: UIImageView!
    private var gotItImageView: UIImageView!
    private var questionCount = 0
    
    var cardContainer: SwipeableCardViewContainer!
    var infoBar: UIView!
    var closeButtonAction: (() -> Void)?
    
    var dismissButtonTitle = "Quit Test" {
        didSet { updateViews() }
    }
    
    var testTitle: String? {
        didSet { updateViews() }
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
    
    // MARK: - Lifecycle Methods
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
    
    // MARK: - UI Actions
    @objc func closeTest(isCompleted: Bool = false) {
        if let action = closeButtonAction {
            action()
        } else {
            if isCompleted {
                dismissTest()
            } else {
                let alertVC = UIAlertController.informationalAlertController(title: .quitTestAlertTitle, message: .quitTestAlertMessage, dismissTitle: "Dismiss", dismissActionCompletion: dismissTest, withCancel: true)
                present(alertVC, animated: true)
            }
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
    
    // MARK: - Swipeable Card View Delegate
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection) {
        questionCount += 1
        if questionCount > 2 { hideArrows() }
        guard let observation = testObservation else { return }
        guard let question = card.question else { return }
        
        let duration = DateInterval(start: startTime, end: Date()).duration
        let response: Response = direction.horizontalPosition == .right ? .correct : .incorrect
        guard let questionID = question.questionID else { fatalError("The Question does not have a questionID")}
        
        _ = coreDataFetchController?.recordQuestionObservation(with: response, for: questionID, with: Int(duration), in: observation)
        
        // Reset timer for the next question
        startTime = Date()
    }
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardViewContainer, isEmpty: Bool) {
        closeTest(isCompleted: true)
    }
    
    // MARK: Private Methods
    private func setupViews() {
        
        // Set background color based on whether or not this is a test
        if testObservation != nil {
            view.backgroundColor = .testBackground
        } else {
            view.backgroundColor = .white
        }
        
        // Set up info bar, a place to put the title, buttons, timer, etc
        infoBar = UIView()
        infoBar.constrainToSuperView(view, top: 0, leading: 0, trailing: 0, height: 60)
        
        let infoStackView = UIStackView()
        infoStackView.axis = .horizontal
        infoStackView.spacing = 8
        infoStackView.constrainToSuperView(infoBar, top: 0, bottom: 0, leading: 20, trailing: 20)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .fadedTextColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        infoStackView.addArrangedSubview(titleLabel)
        
        dismissButton = UIButton(type: .system)
        dismissButton.setTitleColor(.warningColor, for: .normal)
        dismissButton.addTarget(self, action: #selector(closeTest), for: .touchUpInside)
        dismissButton.setContentHuggingPriority(.required, for: .horizontal)
        infoStackView.addArrangedSubview(dismissButton)
        
        // Set up card container
        cardContainer = SwipeableCardViewContainer()
        cardContainer.constrainToSuperView(view, bottom: 60, leading: 20, trailing: 20)
        cardContainer.constrainToSiblingView(infoBar, below: 24)
        
        cardContainer.alpha = 0
        cardContainer.dataSource = self
        cardContainer.delegate = self
        
        // Set up arrow images
        needsWorkImageView = UIImageView(image: UIImage(named: "needs-work"))
        needsWorkImageView.tintColor = .fadedTextColor
        needsWorkImageView.contentMode = .scaleAspectFit
        
        needsWorkImageView.constrainToSuperView(view, bottom: 4, leading: 4, height: 60, width: 200)
        
        gotItImageView = UIImageView(image: UIImage(named: "got-it"))
        gotItImageView.tintColor = .fadedTextColor
        gotItImageView.contentMode = .scaleAspectFit
        
        gotItImageView.constrainToSuperView(view, bottom: 4, trailing: 4, height: 60, width: 200)
        
        // Record start time
        startTime = Date()
        updateViews()
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
    
    private func updateViews() {
        guard isViewLoaded else { return }
        dismissButton.setTitle(dismissButtonTitle, for: .normal)
        titleLabel.text = testTitle
    }
    
    private func dismissTest(action: UIAlertAction! = nil) {
        if testObservation != nil {
            coreDataFetchController?.finishTestAndFinalizeObservation(&testObservation!)
        }
        dismiss(animated: true)
    }
    
    private func hideArrows() {
        if gotItImageView.alpha != 0 {
            UIView.animate(withDuration: 0.5) {
                self.needsWorkImageView.alpha = 0
                self.gotItImageView.alpha = 0
            }
        }
    }
    
}

extension String {
    fileprivate static let quitTestAlertTitle = "Are you sure you want to quit?"
    fileprivate static let quitTestAlertMessage = "Your data thus far will be saved, you will lose out on the remaining questions."
}
