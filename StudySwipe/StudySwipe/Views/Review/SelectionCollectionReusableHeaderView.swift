//
//  SelectionCollectionReusableHeaderView.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class SelectionCollectionReusableHeaderView: UICollectionReusableView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init with code not implemented.")
    }
    
    
    private func setupViews() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .fadedTextColor
        
        titleLabel.constrainToSuperView(self, bottom: 0, leading: 20, trailing: 20)
    }
}
