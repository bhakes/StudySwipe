//
//  LabelledProgressView.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 8/3/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class LabelledProgressView: UIView {

    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutViews()
    }
    
    // MARK: - Convenience Initializer
    convenience init(title: String = "", total: Int = 0) {
        self.init(frame: .zero)
        self.title = title
        self.total = total
    }
    
    
    // MARK: - Properties
    private(set) var total: Int = 0
    private(set) var correct: Int = 0
    
    var title: String = "" {
        didSet { titleLabel.text = title }
    }
    
    private let titleLabel: DMCLabel = {
        let label = UILabel.label(for: .body)
        
        return label
    }()
    
    private let masteredLabel: DMCLabel = {
        let label = UILabel.label(for: .body, with: "0 of 0")
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    var progressTint: UIColor = .blue {
        didSet {
            progressView.progressTintColor = progressTint
        }
    }

    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill

        return stackView
    }()

    private let innerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8

        return stackView
    }()

    private let progressView: DMCProgessView = {
        let progressView = DMCProgessView(progressViewStyle: .default)
        progressView.layer.cornerRadius = 3
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 3
        progressView.subviews[1].clipsToBounds = true
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        
        return progressView
    }()

    // MARK: - Methods
    private func layoutViews() {
        outerStackView.constrainToFill(self)

        innerStackView.addArrangedSubview(titleLabel)
        innerStackView.addArrangedSubview(masteredLabel)

        outerStackView.addArrangedSubview(innerStackView)
        outerStackView.addArrangedSubview(progressView)
    }

    func updateProgress(correct: Int? = nil, total: Int? = nil, animated: Bool = false) {
        if let correct = correct { self.correct = correct }
        if let total = total { self.total = total }
        if self.total < self.correct { self.total = self.correct }

        let progress = Float(self.correct) / Float(self.total)
        masteredLabel.text = "\(self.correct) of \(self.total)"

        if animated {
            UIView.animate(withDuration: 2) {
                self.progressView.setProgress(progress, animated: true)
            }
        } else {
            progressView.progress = progress
        }
    }
}
