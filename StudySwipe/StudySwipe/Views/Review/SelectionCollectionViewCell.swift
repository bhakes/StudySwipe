//
//  SelectionCollectionViewCell.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class SelectionCollectionViewCell: UICollectionViewCell {
    
    var item: ColorIconTitleProviding? {
        didSet {
            updateViews()
        }
    }
    
    lazy var colorView: UIView = {
        let colorView = UIView()
        return colorView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init from coder not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        colorView.constrainToFill(contentView)
        colorView.layer.cornerRadius = 8
        colorView.layer.masksToBounds = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.constrainToSuperView(colorView, top: 12, bottom: 12, leading: 12, trailing: 12)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func updateViews() {
        guard let item = item else { return }
        
        colorView.backgroundColor = item.color()
        
        titleLabel.text = item.title()
        
        imageView.image = item.icon()
    }
}
