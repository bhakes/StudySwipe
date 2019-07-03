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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }
    
    private func setupViews() {
        addSubview(stackView)
        titleLabel.textColor = .gray
        masteredLabel.textColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    var stackViewTopAnchor: NSLayoutConstraint?
    var stackViewBottomAnchor: NSLayoutConstraint?
    var stackViewLeadingAnchor: NSLayoutConstraint?
    var stackViewTrailingAnchor: NSLayoutConstraint?
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor.blue
        progressView.trackTintColor = UIColor.lightGray
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 5
        progressView.subviews[1].clipsToBounds = true
        return progressView
    }()
    var titleLabel: UILabel = UILabel()
    var masteredLabel: UILabel = UILabel()
    lazy var subStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [titleLabel, masteredLabel])
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
        sv.spacing = 8
        sv.constrainToFill(self, safeArea: true, top: 4, bottom: 4, leading: 36, trailing: 36)
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
                masteredLabel.text = "\(correctCategoryCount)/ \(totalCategoryCount)"
                
            }
            
        }
    }
    
}