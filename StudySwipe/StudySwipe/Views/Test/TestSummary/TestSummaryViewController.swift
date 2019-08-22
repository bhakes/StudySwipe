//
//  TestSummaryViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/27/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestSummaryViewController: UIViewController {
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.summarizedCategories.enumerated().forEach {
            progressViews[$0.offset].updateProgress(correct: $0.element.correct, animated: true) }
    }
    
    // MARK: - Properties
    var viewModel: TestObservationViewModel!
    
    var dismissHandler: (() -> Void)?

    var testObservation: InterviewTestObservation! {
        didSet {
            viewModel = TestObservationViewModel(interviewTestObservation: testObservation)
        }
    }

    private var titleLabel: DMCLabel = {
        let label = UILabel.label(for: .title, with: "Summary")
        
        return label
    }()
    
    private var dismissButton: UIButton = {
        let button = UIButton.button(for: .normal, with: "Okay")
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        return button
    }()

    private lazy var testTitleLabel: DMCLabel = {
        let label = UILabel.label(for: .header2)
        label.numberOfLines = 0
        label.text = viewModel.duration

        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()

    private lazy var progressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: progressViews)
        stackView.axis = .vertical
        stackView.spacing = 12

        return stackView
    }()

    private lazy var progressViews: [LabelledProgressView] = viewModel.summarizedCategories.map {
        let progressView = LabelledProgressView(total: $0.total)
        progressView.title = $0.title
        progressView.progressTint = $0.color

        return progressView
    }
    
    private lazy var questionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: questionViews)
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var questionViews: [QuestionSummaryView] = viewModel.summarizedQuestions.map {
        let questionView = QuestionSummaryView()
        questionView.color = $0.color
        questionView.isCorrect = $0.isCorrect
        questionView.question = $0.question
        
        return questionView
    }

    // MARK: - Methods

    private func setupViews() {
        view = DMCView()
        
        titleLabel.constrainToSuperView(view, top: 20, leading: 20, trailing: 20)
        testTitleLabel.constrainToSuperView(view, leading: 20, trailing: 20)
        testTitleLabel.constrainToSiblingView(titleLabel, below: 0)
        scrollView.constrainToSuperView(view, leading: 0, trailing: 0)
        scrollView.constrainToSiblingView(testTitleLabel, below: 12)
        progressStackView.constrainToSuperView(scrollView, safeArea: false, top: 0, leading: 20)
        progressStackView.constrainToSiblingView(view, leading: 20, trailing: 20)
        questionStackView.constrainToSuperView(scrollView, safeArea: false, bottom: 0, leading: 20)
        questionStackView.constrainToSiblingView(progressStackView, below: 20, equalWidth: 0)
        
        dismissButton.constrainToSuperView(view, bottom: 20, centerX: 0, width: 120)
        dismissButton.constrainToSiblingView(scrollView, below: 20)
        view.translatesAutoresizingMaskIntoConstraints = true
    }
    
    @objc func dismissView() {
        if let dismissHandler = dismissHandler {
            dismissHandler()
        } else {
            dismiss(animated: true)
        }
    }
}
