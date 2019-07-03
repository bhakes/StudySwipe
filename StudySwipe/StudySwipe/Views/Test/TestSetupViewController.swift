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
    
    var questionNumberLabel: UILabel!
    var questionSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - UI Actions
    @objc func tenQuestionTest() {
        let number = Int(questionSlider.value)
        startTest(numberOfQuestions: number)
    }
    
    @objc func updateQuestionNumberLabel() {
        let number = Int(questionSlider.value)
        questionNumberLabel.text = "\(number) Questions"
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        let titleLabel = UILabel()
        titleLabel.text = "Take a Test"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        
        titleLabel.constrainToSuperView(view, top: 20, leading: 20, trailing: 20)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.constrainToSuperView(view, centerX: 0, centerY: 0, width: 240)
        
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
        
        let startTestButton = UIButton(type: .system)
        startTestButton.setTitle("Start Test", for: .normal)
        startTestButton.setTitleColor(.white, for: .normal)
        startTestButton.backgroundColor = .accentColor
        startTestButton.addTarget(self, action: #selector(tenQuestionTest), for: .touchUpInside)
        startTestButton.layer.cornerRadius = 8
        
        startTestButton.constrainToSuperView(view, bottom: 48, centerX: 0, height: 40, width: 120)
    }
    
    private func startTest(numberOfQuestions number: Int) {
        let (test, observation) = coreDataFetchController.makeTestAndObservation(with: "New \(number) Question Test", count: number, random: true)
        let testViewController = TestViewController()
        testViewController.coreDataFetchController = coreDataFetchController
        testViewController.testObservation = observation
        testViewController.test = test
        
        present(testViewController, animated: true)
    }
}
