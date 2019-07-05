//
//  TestSetupViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestSetupViewController: UIViewController {
    
    let coreDataFetchController = CoreDataFetchController()
    
    var quoteLabel: UILabel!
    var authorLabel: UILabel!
    
    var segmentedControl: UISegmentedControl!
    var questionNumberLabel: UILabel!
    var questionSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateQuote()
    }
    
    // MARK: - UI Actions
    @objc func startCustomTest() {
        let number = Int(questionSlider.value)
        let difficulty = Difficulty.allCases[segmentedControl.selectedSegmentIndex]
        startTest(difficulty: difficulty, numberOfQuestions: number)
    }
    
    @objc func updateQuestionNumberLabel() {
        let number = Int(questionSlider.value)
        questionNumberLabel.text = "\(number) Questions"
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        // Set up Tab Bar
        
        
        // Set up Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Take a Test"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        
        titleLabel.constrainToSuperView(view, top: 20, leading: 20, trailing: 20)
        
        // Set up Main Stack
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.alignment = .center
        
        mainStack.constrainToSuperView(view, bottom: 20, leading: 20, trailing: 20)
        mainStack.constrainToSiblingView(titleLabel, below: 20)
        
        let spacer1 = UIView()
        mainStack.addArrangedSubview(spacer1)
        
        // Set up Quote Stack
        let quoteStack = UIStackView()
        quoteStack.axis = .vertical
        quoteStack.spacing = 12
        
        mainStack.addArrangedSubview(quoteStack)
        quoteStack.constrain(width: 300)
        
        quoteLabel = UILabel()
        quoteLabel.textColor = .fadedTextColor
        quoteLabel.textAlignment = .center
        quoteLabel.numberOfLines = 0
        quoteLabel.font = UIFont.italicSystemFont(ofSize: 18)
        
        quoteStack.addArrangedSubview(quoteLabel)
        
        authorLabel = UILabel()
        authorLabel.textColor = .fadedTextColor
        authorLabel.textAlignment = .right
        authorLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        quoteStack.addArrangedSubview(authorLabel)
        
        let spacer2 = UIView()
        mainStack.addArrangedSubview(spacer2)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        
        stackView.constrain(width: 240)
        mainStack.addArrangedSubview(stackView)
        
        let spacer3 = UIView()
        mainStack.addArrangedSubview(spacer3)
        
        // Set up Difficulty Segmented Control
        let difficulties = Difficulty.allCases.map { $0.title() }
        segmentedControl = UISegmentedControl(items: difficulties)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .accentColor
        
        stackView.addArrangedSubview(segmentedControl)
        
        // Set up Question Count Slider
        questionNumberLabel = UILabel()
        questionNumberLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        questionNumberLabel.textAlignment = .center
        stackView.addArrangedSubview(questionNumberLabel)
        
        let sliderContainer = UIView()
        sliderContainer.backgroundColor = .accentColor
        sliderContainer.layer.cornerRadius = 8
        stackView.addArrangedSubview(sliderContainer)
        
        questionSlider = UISlider()
        questionSlider.minimumValue = 5
        questionSlider.maximumValue = 30
        questionSlider.setValue(10, animated: false)
        questionSlider.tintColor = .white
        questionSlider.maximumTrackTintColor = .white
        
        questionSlider.addTarget(self, action: #selector(updateQuestionNumberLabel), for: .primaryActionTriggered)
        
        updateQuestionNumberLabel()
        
        questionSlider.constrainToSuperView(sliderContainer, top: 8, bottom: 8, leading: 20, trailing: 20)
        
        // Set up Start Test Button
        let startTestButton = UIButton(type: .system)
        startTestButton.setTitle("Start Test", for: .normal)
        startTestButton.setTitleColor(.white, for: .normal)
        startTestButton.backgroundColor = .accentColor
        startTestButton.addTarget(self, action: #selector(startCustomTest), for: .touchUpInside)
        startTestButton.layer.cornerRadius = 8
        
        startTestButton.constrain(width: 120)
        mainStack.addArrangedSubview(startTestButton)
        
        let spacer4 = UIView()
        mainStack.addArrangedSubview(spacer4)
        
        spacer1.constrainToSiblingView(spacer2, equalHeight: 0)
        spacer2.constrainToSiblingView(spacer3, equalHeight: 0)
        spacer3.constrainToSiblingView(spacer4, equalHeight: 0)
    }
    
    private func updateQuote() {
        let (author, quote) = Quotes.getNewQuote()
        quoteLabel.text = "\"\(quote)\""
        authorLabel.text = "– \(author)"
    }
    
    private func startTest(difficulty: Difficulty = .All, numberOfQuestions number: Int) {
        let (test, observation) = coreDataFetchController.makeTestAndObservation(with: "New \(number) Question Test", difficulties: [difficulty], count: number, random: true)
        let testViewController = TestViewController()
        testViewController.coreDataFetchController = coreDataFetchController
        testViewController.testObservation = observation
        testViewController.test = test
        
        present(testViewController, animated: true)
    }
}
