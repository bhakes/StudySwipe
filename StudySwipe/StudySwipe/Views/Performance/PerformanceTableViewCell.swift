//
//  PerformanceTableViewCell.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class PerformanceTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: cellID)
        
        setupViews()
        setUpTheming()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))
    }
    
    private func setupViews() {
        addSubview(stackView)
//        titleLabel.textColor = .gray
//        masteredLabel.textColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    var stackViewTopAnchor: NSLayoutConstraint?
    var stackViewBottomAnchor: NSLayoutConstraint?
    var stackViewLeadingAnchor: NSLayoutConstraint?
    var stackViewTrailingAnchor: NSLayoutConstraint?
    
    let progressView: DMCProgessView = {
        let progressView = DMCProgessView(progressViewStyle: .default)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        progressView.layer.cornerRadius = 3
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 3
        progressView.subviews[1].clipsToBounds = true
        return progressView
    }()
    var titleLabel: UILabel = UILabel()
    var masteredLabel: UILabel = UILabel()
    lazy var subStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [titleLabel, masteredLabel])
        titleLabel.textColor = .fadedTextColor
        masteredLabel.textColor = .fadedTextColor
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.spacing = 8
        sv.constrainToFill(self, top: 4, bottom: 4, leading: 36, trailing: 36)
        return sv
    }()
    lazy var stackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [subStackView, progressView])
        sv.alignment = .fill
        sv.axis = .vertical
        sv.constrainToFill(self, safeArea: true, top: 4, bottom: 4, leading: 20, trailing: 20)
        return sv
    }()
    
    let cellID = "cellID"
    var totalCategoryCount: Int = 1
    var correctCategoryCount: Int = 0
    var progressPercentage: Double = 0.0 {
        didSet {
            progressView.progress = Float(self.progressPercentage)
        }
    }
    var numberOfQuestions: Int = 0
    var category: Category? {
        didSet {
            titleLabel.text = self.category?.rawValue
            progressView.progressTintColor = self.category?.color() ?? .blue
        }
    }
    var categoryQuestions: [Question]? {
        didSet {
            if let count = self.categoryQuestions?.count {
                self.totalCategoryCount = count
            }
        
        }
    }
    
    var categoryMasteredQuestions: [Question]? {
        didSet {
            if let count = self.categoryMasteredQuestions?.count {
                masteredLabel.text = "\(count)"
                self.correctCategoryCount = count
                if totalCategoryCount != 0 {
                    progressPercentage = Double(correctCategoryCount) / Double(totalCategoryCount)
                }
                let heading = category == .All ? " Concepts": ""
                masteredLabel.text = "\(correctCategoryCount) of \(totalCategoryCount)\(heading)"
                
            }
            
        }
    }
    
}


extension PerformanceTableViewCell: Themed {
    func applyTheme(_ theme: AppTheme) {
        
        backgroundColor = theme.backgroundColor
        
    }
}
