//
//  DarkModeTableViewCell.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/13/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

protocol DarkModeCellDelegate {
    func darkModeDidChange()
}

class DarkModeTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: darkCellID)
        
        setupViews()
        setUpTheming()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.stackView.subviews.forEach { $0.removeFromSuperview() }
        
        label.text = "Tap to Change Dark/Light Mode"
        
        darkModeSwitch.isOn = AppThemeProvider.shared.currentTheme == AppTheme.dark ? true : false
        
        self.stackView = UIStackView(arrangedSubviews: [label])
        self.stackView.axis = .horizontal
        self.stackView.spacing = 8
        self.stackView.constrainToSuperView(self, top: 10, bottom: 10, leading: 20, trailing: 20)
       
    }
    
    func darkModeSwitchChanged() {

        AppThemeProvider.shared.nextTheme()
    }
    
    let darkCellID = "darkCellID"
    var delegate: DarkModeCellDelegate?
    let darkModeSwitch = DMCSwitch()
    let label = DMCLabel()
    var stackView = UIStackView()
}


extension DarkModeTableViewCell: Themed {
    func applyTheme(_ theme: AppTheme) {
        
        backgroundColor = theme.cellBackgroundColor

    }
}
