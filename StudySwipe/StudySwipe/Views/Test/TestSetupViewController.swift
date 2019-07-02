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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    @objc func tenQuestionTest() {
        startTest(numberOfQuestions: 10)
    }
    
    @objc func twentyQuestionTest() {
        startTest(numberOfQuestions: 20)
    }
    
    private func setupViews() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.constrainToSuperView(view, centerX: 0, centerY: 0, width: 200)
        
        let tenTestButton = UIButton(type: .system)
        tenTestButton.setTitle("Ten Question Test", for: .normal)
        tenTestButton.addTarget(self, action: #selector(tenQuestionTest), for: .touchUpInside)
        
        stackView.addArrangedSubview(tenTestButton)
        
        let twentyTestButton = UIButton(type: .system)
        twentyTestButton.setTitle("Twenty Question Test", for: .normal)
        twentyTestButton.addTarget(self, action: #selector(twentyQuestionTest), for: .touchUpInside)
        
        stackView.addArrangedSubview(twentyTestButton)
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
