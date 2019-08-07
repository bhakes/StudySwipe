//
//  QuestionSummaryView.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 8/4/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class QuestionSummaryView: UIView {
    
    var question: String? {
        didSet {
            questionLabel.text = question
        }
    }
    
    var color: UIColor = .accentColor
    
    var isCorrect: Bool = false {
        didSet {
            updateViews()
        }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let questionLabel: DMCLabel = {
        let label = UILabel.label(for: .body)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutViews()
    }
    
    private func layoutViews() {
        imageView.constrain(height: 30, width: 30)
        
        stackView.constrainToFill(self)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(questionLabel)
        
        updateViews()
    }
    
    private func updateViews() {
        if isCorrect {
            imageView.image = UIImage(named: "ok")
            imageView.tintColor = color
        } else {
            imageView.image = UIImage(named: "cancel")
            imageView.tintColor = .fadedTextColor
        }
    }

}
