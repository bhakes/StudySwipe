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
        let titleLabel = UILabel.label(for: .header2)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setUpTheming()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init with code not implemented.")
    }
    
    
    private func setupViews() {
        titleLabel.sizeToFit()
        titleLabel.constrainToSuperView(self, bottom: 0, leading: 20, trailing: 20)
    }
}

extension SelectionCollectionReusableHeaderView: Themed {
    func applyTheme(_ theme: AppTheme) {
        
        backgroundColor = theme.backgroundColor
        
    }
}
