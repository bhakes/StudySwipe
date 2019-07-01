//
//  SwipeableCard.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class SwipeableCard: SwipeableView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init from coder not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 4, height: 10)
    }
    
    func fillWithQuestion(_ question: Question) {
        let questionLabel = UILabel()
        questionLabel.text = question.question ?? question.sampleText
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 32)
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.preferredMaxLayoutWidth = SwipeableCardViewContainer.preferredWidth
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
        ])
    }
    
}
