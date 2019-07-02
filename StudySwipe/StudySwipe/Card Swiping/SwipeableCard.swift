//
//  SwipeableCard.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class SwipeableCard: SwipeableView {
    
    var answerTextView: UITextView!
    var instructionLabel: UILabel!
    private var isAnswerHidden = true
    
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        
        stackView.constrainToSuperView(self, safeArea: false, top: 20, bottom: 20, leading: 12, trailing: 12)
        
        let questionLabel = UILabel()
        questionLabel.text = question.question ?? sampleText
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 24)
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        
        stackView.addArrangedSubview(questionLabel)
        
        
        let divider = UIView()
        divider.backgroundColor = .black
        divider.layer.cornerRadius = 3
        divider.constrain(height: 5)
        
        stackView.addArrangedSubview(divider)
        
        answerTextView = UITextView()
        answerTextView.text = question.answer ?? ""
        answerTextView.font = UIFont.systemFont(ofSize: 16)
        answerTextView.textAlignment = .center
        answerTextView.isEditable = false
        answerTextView.alpha = 0.0
        
        stackView.addArrangedSubview(answerTextView)
        answerTextView.constrainToSiblingView(questionLabel, equalHeight: 0)
        
        instructionLabel = UILabel()
        instructionLabel.textAlignment = .center
        instructionLabel.text = "Tap to show answer"
        
        instructionLabel.constrainToSuperView(self, height: 24, width: 200)
        instructionLabel.constrainToSiblingView(answerTextView, centerX: 0, centerY: 0)
        
        self.layoutSubviews()

    }
    
    func handleTap() {
        toggleAnswerTextLabel()
    }
    
    private func toggleAnswerTextLabel() {
        let answerAlpha: CGFloat = isAnswerHidden ? 1.0 : 0.0
        let instructionAlpha: CGFloat = isAnswerHidden ? 0.0 : 1.0
        isAnswerHidden.toggle()
        UIView.animate(withDuration: 0.3) {
            self.answerTextView.alpha = answerAlpha
            self.instructionLabel.alpha = instructionAlpha
        }
    }
    
    let sampleText = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non cursus velit. Sed varius ipsum a diam dapibus ullamcorper.
    """
    
}
