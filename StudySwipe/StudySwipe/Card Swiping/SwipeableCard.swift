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
        questionLabel.text = question.question ?? sampleText
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 32)
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.preferredMaxLayoutWidth = SwipeableCardViewContainer.preferredWidth
        
        questionLabel.constrainToSuperView(self, safeArea: false, top: 12, leading: 12, trailing: -12)

    }
    
    let sampleText = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non cursus velit. Sed varius ipsum a diam dapibus ullamcorper.
    """
    
}
