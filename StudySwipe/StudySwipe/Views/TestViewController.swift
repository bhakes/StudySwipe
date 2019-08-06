//
//  TestViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit
import CoreData

class TestViewController: UIViewController, SwipeableCardViewDelegate, SwipeableCardViewDataSource, StopwatchDelegate {
    
    // MARK: - Properties
    private var dismissButton: UIButton!
    private var titleLabel: UILabel!
    private var startTime = Date()
    private var needsWorkImageView: UIImageView!
    private var gotItImageView: UIImageView!
    private var questionCount = 0
    private var stopwatch: Stopwatch!
    
    var cardContainer: SwipeableCardViewContainer!
    
    private var themedStatusBarStyle: UIStatusBarStyle?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
            self.questions = Array(questions) as! [Question]
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
        setUpTheming()
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
        let card = QuestionCard()
        card.backgroundColor = .white
        
        let question = questions[index]
        card.question = question
        return card
    }
    
    // MARK: - Swipeable Card View Delegate
    func card(_ card: SwipeableCard, didCommitSwipeInDirection direction: SwipeDirection) {
        guard let card = card as? QuestionCard else {
            fatalError("The card is a different type that expected")
        }
        questionCount += 1
        if questionCount > 2 { hideArrows() }
        guard let observation = testObservation else { return }
        guard let question = card.question else { return }
        
        let duration = DateInterval(start: startTime, end: Date()).duration
        let response: Response = direction.horizontalPosition == .right ? .correct : .incorrect
        guard let questionID = question.questionID else { fatalError("The Question does not have a questionID")}
        
        if let cdfc = coreDataFetchController {
            
            // check to see if the question has been mastered
            let isMastered = cdfc.questionIsMastered(for: question)
            
            // record the question observation
            _ = cdfc.recordQuestionObservation(with: response, for: questionID, with: Int(duration), in: observation)
            
            // if the repose was "correct" & the question wasn't previously mastered
            if response == .correct && isMastered == false {
                    displayPillView(for: question)
            }
            
        }
        // Reset timer for the next question
        startTime = Date()
    }
    
    func cardViewContainer(_ cardViewContainer: SwipeableCardViewContainer, isEmpty: Bool) {
        closeTest(isCompleted: true)
    }
    
    // MARK: - Stopwatch Delegate
    func stopwatch(_ stopwatch: Stopwatch, didChangeTimeTo: TimeInterval) {
        testTitle = stopwatch.formattedTime
    }
    
    // MARK: Private Methods
    private func setupViews() {
        
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
        
        // Set up arrow images
        gotItImageView = UIImageView(image: UIImage(named: "got-it"))
        gotItImageView.tintColor = .fadedTextColor
        gotItImageView.contentMode = .scaleAspectFit
        gotItImageView.constrainToSuperView(view, bottom: 4, trailing: 4, height: 60, width: 200)
        
        needsWorkImageView = UIImageView(image: UIImage(named: "needs-work"))
        needsWorkImageView.tintColor = .fadedTextColor
        needsWorkImageView.contentMode = .scaleAspectFit
        needsWorkImageView.constrainToSuperView(view, bottom: 4, leading: 4, height: 60, width: 200)
        needsWorkImageView.superview?.bringSubviewToFront(needsWorkImageView)
        
        // Set up card container
        // This is done last so that it sits over the other elements
        cardContainer = SwipeableCardViewContainer()
        cardContainer.constrainToSuperView(view, bottom: 60, leading: 20, trailing: 20)
        cardContainer.constrainToSiblingView(infoBar, below: 0)
        cardContainer.alpha = 0
        cardContainer.dataSource = self
        cardContainer.delegate = self
        
        // Record start time
        startTime = Date()
        
        // Set things that depend on whether or not this is a test
        if testObservation != nil {
            view.backgroundColor = AppThemeProvider.shared.currentTheme == AppTheme.dark ? AppThemeProvider.shared.currentTheme.backgroundColor : .testBackground
            stopwatch = Stopwatch()
            stopwatch.delegate = self
            stopwatch.start()
        } else {
           view.backgroundColor = AppThemeProvider.shared.currentTheme == AppTheme.dark ? AppThemeProvider.shared.currentTheme.backgroundColor : .white
        }
        
        
        
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
            
            guard let test = test else { return }
            testObservation = coreDataFetchController?.finishTestAndFinalizeObservation(&testObservation!, for:test)
            
            let questionObs = testObservation?.questionObservation?.array as? [QuestionObservation]
            print(questionObs?.compactMap{ $0.response })

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
    
    private func displayPillView(for question: Question) {
        guard let category = Category(rawValue: question.category ?? "") else { return }
        let pillView = PillView(color: category.color(), text: "+1 \(category.title())")
        pillView.borderColor = .white
        pillView.shadowOpacity = 0.3
        pillView.alpha = 0
        
        pillView.constrainToSuperView(view, safeArea: true, top: 20, centerX: 0)
        
        let fadeIn = {
            pillView.alpha = 1
        }
        
        let fadeOut = {
            pillView.alpha = 0
        }
        
        let completion: (Bool) -> Void = { _ in
            pillView.removeFromSuperview()
        }
        
        if let pVC = self.presentingViewController as? DMCTabBarController {
            // In this case we want to modify the badge number of the third tab:
            
            let tabItem = pVC.tabBar.items?[2]
            if let value = tabItem?.badgeValue, value != "" {
                if let uintValue = UInt.init(value) {
                    tabItem?.badgeValue = "\(uintValue + 1)"
                    setMasteryUpdatesToUserDefaults(uintValue + 1)
                } else {
                    tabItem?.badgeValue = "1"
                }
                
            } else {
                tabItem?.badgeValue = "1"
            }
            
        }
        
        UIView.animate(withDuration: 0.2, animations: fadeIn) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5, animations: fadeOut, completion: completion)
        }
    }
    
}

extension String {
    fileprivate static let quitTestAlertTitle = "Are you sure you want to quit?"
    fileprivate static let quitTestAlertMessage = "Your data thus far will be saved, you will lose out on the remaining questions."
}


extension TestViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()

    }
}
