//
//  TestConfigurationViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/18/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestConfigurationViewController: UIViewController {

    let coreDataFetchController = CoreDataFetchController()
    
    var quoteLabel: UILabel!
    var authorLabel: UILabel!
    var masteredLabel: UILabel!
    var masteredSwitch: UISwitch!
    var segmentedControl: UISegmentedControl!
    var questionNumberLabel: UILabel!
    var questionSlider: UISlider!
    var resetButton: UIButton!
    
    private var optionsCollectionViewController: TestConfigurationCollectionViewController!
    
    private var themedStatusBarStyle: UIStatusBarStyle?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themedStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        //        setUpTheming()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        updateQuote()
    }
    
    // MARK: - UI Actions
    @objc func startCustomTest() {
        let number = Int(questionSlider.value)
        let difficulties = optionsCollectionViewController.selectedDifficulties.isEmpty ? [.All] : optionsCollectionViewController.selectedDifficulties
        let categories = optionsCollectionViewController.selectedCategories.isEmpty ? [.All] : optionsCollectionViewController.selectedCategories
        let notMasteredOnly = !masteredSwitch.isOn
        
        startTest(difficulties: difficulties, categories: categories, numberOfQuestions: number, notMasteredOnly: notMasteredOnly)
    }
    
    @objc func updateQuestionNumberLabel() {
        let number = Int(questionSlider.value)
        questionNumberLabel.text = "\(number) Questions"
        
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        
        self.view = DMCView()
        
        // Set up Title Label
        let titleLabel = DMCLabel()
        titleLabel.text = "Take a Test"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        
        titleLabel.constrainToSuperView(view, top: 20, leading: 20, trailing: 20)
        
        // Set up Main Stack
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.alignment = .center
        
        mainStack.constrainToSuperView(view, bottom: 36, leading: 20, trailing: 20)
        mainStack.constrainToSiblingView(titleLabel, below: 20)
        
        // Setup Options Collection View
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .fadedTextColor
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = "Tap to remove from the test: "
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        mainStack.addArrangedSubview(descriptionLabel)
        
        let layout = CenterAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        optionsCollectionViewController = TestConfigurationCollectionViewController(collectionViewLayout: layout)

        let optionsView = DMCView()
        optionsView.backgroundColor = .gray
        mainStack.addArrangedSubview(optionsView)
        optionsView.constrainToSiblingView(mainStack, equalWidth: 0)

        add(optionsCollectionViewController, toView: optionsView)
        
        // Set up Question Count Slider
        questionNumberLabel = UILabel()
        questionNumberLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        questionNumberLabel.textAlignment = .center
        questionNumberLabel.textColor = .fadedTextColor
        mainStack.addArrangedSubview(questionNumberLabel)
        
        let sliderContainer = UIView()
        sliderContainer.backgroundColor = .accentColor
        sliderContainer.layer.cornerRadius = 24
        mainStack.addArrangedSubview(sliderContainer)
        
        questionSlider = UISlider()
        questionSlider.minimumValue = 5
        questionSlider.maximumValue = 30
        questionSlider.setValue(10, animated: false)
        questionSlider.tintColor = .white
        questionSlider.maximumTrackTintColor = .white
        questionSlider.constrain(width: 240)
        
        questionSlider.addTarget(self, action: #selector(updateQuestionNumberLabel), for: .primaryActionTriggered)
        
        updateQuestionNumberLabel()
        
        questionSlider.constrainToSuperView(sliderContainer, top: 8, bottom: 8, leading: 20, trailing: 20)
        
        // Set up Master Card Toggle
        masteredLabel = UILabel()
        masteredLabel.numberOfLines = 1
        masteredLabel.textColor = .fadedTextColor
        masteredLabel.textAlignment = .left
        masteredLabel.text = "Include mastered cards: "
        masteredLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        
        masteredSwitch = UISwitch()
        masteredSwitch.onTintColor = .accentColor
        masteredSwitch.isOn = true
        
        let isMasteredStackView = UIStackView(arrangedSubviews: [masteredLabel, masteredSwitch])
        isMasteredStackView.axis = .horizontal
        isMasteredStackView.spacing = 12
        
        isMasteredStackView.constrain(width: 240)
        mainStack.addArrangedSubview(isMasteredStackView)
        
        
        
        // Set up Buttons
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20
        
        mainStack.addArrangedSubview(buttonStack)
        
        resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .warningColor
        resetButton.addTarget(self, action: #selector(resetOptions), for: .touchUpInside)
        resetButton.layer.cornerRadius = 8
        resetButton.constrain(width: 120)
        
        buttonStack.addArrangedSubview(resetButton)
        //        resetButton.isHidden = true
        
        // Set up Start Test Button
        let startTestButton = UIButton(type: .system)
        startTestButton.setTitle("Start Test", for: .normal)
        startTestButton.setTitleColor(.white, for: .normal)
        startTestButton.backgroundColor = .accentColor
        startTestButton.addTarget(self, action: #selector(startCustomTest), for: .touchUpInside)
        startTestButton.layer.cornerRadius = 8
        
        startTestButton.constrain(width: 120)
        
        buttonStack.addArrangedSubview(startTestButton)
    }
    
    //    private func updateQuote() {
    //        let (author, quote) = Quotes.getNewQuote()
    //        quoteLabel.text = "\"\(quote)\""
    //        authorLabel.text = "– \(author)"
    //    }
    
    private func startTest(difficulties: [Difficulty] = [.All], categories: [Category] = [.All], numberOfQuestions number: Int, notMasteredOnly: Bool = false) {
        let (test, observation) = coreDataFetchController.makeTestAndObservation(with: "New \(number) Question Test", difficulties: difficulties, categories: categories, count: number, random: true, notMasteredOnly: notMasteredOnly)
        
        guard test?.questions?.count ?? 0 > 0 else {
            // TODO: Handle having a test with no questions.
            // Maybe present an alert if the test has less questions than was asked for?
            return
        }
        let testViewController = TestViewController()
        testViewController.coreDataFetchController = coreDataFetchController
        testViewController.testObservation = observation
        testViewController.test = test
        
        present(testViewController, animated: true)
    }
    
    @objc private func resetOptions() {
        questionSlider.setValue(10, animated: true)
        updateQuestionNumberLabel()
        optionsCollectionViewController.resetSelection()
    }

}
