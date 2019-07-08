//
//  QuestionCard.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/7/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class QuestionCard: SwipeableCard {
    
    var question: Question? {
        didSet {
            updateViews()
        }
    }
    var answerTextView: UITextView!
    var instructionLabel: UILabel!
    
    private var questionContainer: UIView!
    private var answerContainer: UIView!
    private var isAnswerHidden = true
    
    func updateViews() {
        guard let question = question,
            let categoryString = question.category,
            let cardColor = Category(rawValue: categoryString)?.color() else { return }
        
        backgroundColor = cardColor
        let borderView = UIView()
        borderView.layer.borderColor = UIColor.white.cgColor
        borderView.layer.borderWidth = 2
        borderView.layer.cornerRadius = layer.cornerRadius - 4
        borderView.constrainToSuperView(self, top: 6, bottom: 6, leading: 6, trailing: 6)
        
        questionContainer = UIView()
        questionContainer.constrainToSuperView(self, top: 20, bottom: 20, leading: 20, trailing: 20)
        
        let questionLabel = UILabel()
        questionLabel.text = question.question ?? sampleText
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 36)
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.textColor = .white
        
        questionLabel.constrainToSuperView(questionContainer, leading: 0, trailing: 0, centerY: 0)
        
        answerContainer = UIView()
        answerContainer.isHidden = true
        
        answerContainer.constrainToSuperView(self, top: 20, bottom: 48, leading: 20, trailing: 20)
        
        answerTextView = UITextView()
        answerTextView.text = question.answer ?? ""
        answerTextView.font = UIFont.systemFont(ofSize: 20)
        answerTextView.textAlignment = .center
        answerTextView.isEditable = false
        answerTextView.textColor = .white
        answerTextView.backgroundColor = .clear
        
        answerTextView.constrainToSuperView(answerContainer, top: 0, bottom: 0, leading: 0, trailing: 0)
        
        instructionLabel = UILabel()
        instructionLabel.textAlignment = .center
        instructionLabel.text = "Tap to show answer"
        instructionLabel.textColor = .white
        
        instructionLabel.constrainToSuperView(self, bottom: 20, leading: 20, trailing: 20)
        
        self.layoutSubviews()
        
    }
    
    func handleTap() {
        toggleAnswerTextLabel()
    }
    
    private func toggleAnswerTextLabel() {
        isAnswerHidden.toggle()
        questionContainer.isHidden = !isAnswerHidden
        answerContainer.isHidden = isAnswerHidden
    }
    
    let sampleText = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non cursus velit. Sed varius ipsum a diam dapibus ullamcorper.
    """
    
}
