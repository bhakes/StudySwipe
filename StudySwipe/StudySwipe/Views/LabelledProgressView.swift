//
//  LabelledProgressView.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 8/3/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

/// A container view class for displaying custom `UIProgressView`s with some assocated labels.
class LabelledProgressView: UIView {

    // MARK: - Initializers
    
    /**
     Initializes a new `LabelledProgressView` with the given frame.
     
     - Parameters:
        - frame: The frame of the new ProgressView container
     
     - Returns: A beautiful, ProgressView container,
     custom-built just for you.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutViews()
    }
    
    // MARK: - Convenience Initializer
    
    /**
     Initializes a basic new `LabelledProgressView`, a container class, with a `frame` of `.zero` and sets some of its basic parameters.
     
     - Parameters:
        - title: The `title` of the new `LabelledProgressView`. The default is `""`.
        - total: The `total` of the new `LabelledProgressView`. The default is `0`.
     
     - Returns: A beautiful, `LabelledProgressView`,
     custom-built just for you.
     */
    convenience init(title: String = "", total: Int = 0) {
        self.init(frame: .zero)
        self.title = title
        self.total = total
    }
    
    
    // MARK: - Properties
    
    /// The total count of the elements the ProgressView is representing
    private(set) var total: Int = 0
    /// The count of the correct/mastered elements the ProgressView is representing
    private(set) var correct: Int = 0
    /// The string to display in the `LabelledProgressView`s `titleLabel`.
    var title: String = "" {
        didSet { titleLabel.text = title }
    }
    /// A Dark-mode conforming label to display the title of the view.
    private let titleLabel: DMCLabel = {
        let label = UILabel.label(for: .body)
        
        return label
    }()
    /// A Dark-mode conforming label to display number of correct/mastered questions.
    private let masteredLabel: DMCLabel = {
        let label = UILabel.label(for: .body, with: "0 of 0")
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    /// The color associate with the `UIProgressView`'s `progressTintColor`.
    var progressTint: UIColor = .blue {
        didSet {
            progressView.progressTintColor = progressTint
        }
    }
    /// A stack view that contains the labels stack view and the `UIProgressView` and fills the `LabelledProgressView`.
    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill

        return stackView
    }()
    /// A stack view that contains the labels associated with the `UIProgressView`.
    private let innerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8

        return stackView
    }()
    /// A dark-mode conforming `UIProgressView`.
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
    
    /**
     Lays out the `UIProgresView` and associated labels within the `LabelledProgressView`.
     */
    private func layoutViews() {
        outerStackView.constrainToFill(self)

        innerStackView.addArrangedSubview(titleLabel)
        innerStackView.addArrangedSubview(masteredLabel)
        
        outerStackView.addArrangedSubview(innerStackView)
        outerStackView.addArrangedSubview(progressView)
    }

    /**
     Initializes a new `LabelledProgressView` with the given frame.
     
     - Parameters:
         - correct: An `Int?` representing the new count of the correct/mastered elements the ProgressView is representing. This defaults to `nil`.
         - total: An `Int?` representing the new count of the *total* elements the ProgressView is representing. This defaults to `nil`.
         - animated: A `Bool` representing whether the update should trigger a `UIView`-based animation updating the `ProgressView`'s progress. This defaults to `false`.
     
     */
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
