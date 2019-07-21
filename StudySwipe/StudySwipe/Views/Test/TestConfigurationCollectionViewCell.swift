//
//  TestConfigurationCollectionViewCell.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/18/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestConfigurationCollectionViewCell: UICollectionViewCell {
    
    lazy private var pillView: PillView = {
        let pillView = PillView()
        return pillView
    }()
    
    var item: ColorIconTitleProviding? {
        didSet { updatePillView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init from coder not implemented")
    }
    
    func setColor(to color: UIColor) {
        pillView.color = color
    }
    
    private func setupViews() {
        pillView.constrainToFill(self)
    }
    
    private func updatePillView() {
        guard let item = item else { return }
        pillView.color = item.color()
        pillView.text = item.title()
    }
}
