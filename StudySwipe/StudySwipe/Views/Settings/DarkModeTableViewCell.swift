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
        
        label.text = "Dark Mode"
        
        darkModeSwitch.isOn = AppThemeProvider.shared.currentTheme == AppTheme.dark ? true : false
        darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchChanged(sender:)), for: .valueChanged)
        
        let dMStackView = UIStackView(arrangedSubviews: [label, darkModeSwitch])
        dMStackView.axis = .horizontal
        dMStackView.spacing = 8
        dMStackView.constrainToSuperView(self, top: 2, bottom: 2, leading: 20, trailing: 20)
       
    }
    
    @objc func darkModeSwitchChanged(sender: DMCSwitch) {

        AppThemeProvider.shared.nextTheme()
        
    }
    
    let darkCellID = "darkCellID"
    var delegate: DarkModeCellDelegate?
    let darkModeSwitch = DMCSwitch()
    let label = DMCLabel()
}


extension DarkModeTableViewCell: Themed {
    func applyTheme(_ theme: AppTheme) {
        
        backgroundColor = theme.cellBackgroundColor

    }
}
