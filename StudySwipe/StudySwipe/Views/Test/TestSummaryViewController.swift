//
//  TestSummaryViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/27/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestSummaryViewController: UIViewController {
    
    var dismissHandler: (() -> Void)?
    
    var testObservation: InterviewTestObservation! {
        didSet {
            viewModel = TestObservationViewModel(interviewTestObservation: testObservation)
        }
    }

    var viewModel: TestObservationViewModel!
    
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

    private lazy var progressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: progressViews)
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    private lazy var progressViews: [LabelledProgressView] = viewModel.summarizedCategories.map {
        let progressView = LabelledProgressView(total: $0.total)
        progressView.title = $0.title
        progressView.progressTint = .accentColor

        return progressView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.summarizedCategories.enumerated().forEach { progressViews[$0.offset].updateProgress(correct: $0.element.correct, animated: true) }
    }

    private func setupViews() {
        view = DMCView()
        
        titleLabel.constrainToSuperView(view, top: 20, leading: 20, trailing: 20)
        testTitleLabel.constrainToSuperView(view, leading: 20, trailing: 20)
        testTitleLabel.constrainToSiblingView(titleLabel, below: 0)
        progressStackView.constrainToSuperView(view, leading: 20, trailing: 20)
        progressStackView.constrainToSiblingView(testTitleLabel, below: 20)
        
        dismissButton.constrainToSuperView(view, bottom: 20, centerX: 0, width: 120)
    }
    
    @objc func dismissView() {
        if let dismissHandler = dismissHandler {
            dismissHandler()
        } else {
            dismiss(animated: true)
        }
    }
}
