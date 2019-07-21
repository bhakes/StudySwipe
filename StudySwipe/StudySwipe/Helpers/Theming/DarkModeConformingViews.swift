//
//  DarkModeConformingViews.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/13/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import UIKit

class DMCView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTheming()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DMCView: Themed {
    func applyTheme(_ theme: AppTheme) {
        backgroundColor = theme.backgroundColor
    
    }
}

class DMCCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DMCCollectionView: Themed {
    func applyTheme(_ theme: AppTheme) {
        backgroundColor = theme.backgroundColor
        
    }
}


class DMCLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTheming()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DMCLabel: Themed {
    func applyTheme(_ theme: AppTheme) {
        self.textColor = theme.textColor
        
    }
}


class DMCTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheming()
    }
}

extension DMCTabBarController: Themed {
    func applyTheme(_ theme: AppTheme) {
        tabBar.barTintColor = theme.barBackgroundColor
        tabBar.tintColor = theme.barForegroundColor
        
    }
}

class DMCTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
}

extension DMCTableViewCell: Themed {
    func applyTheme(_ theme: AppTheme) {
        backgroundColor = theme.backgroundColor
        
    }
}

class DMCProgessView: UIProgressView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTheming()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DMCProgessView: Themed {
    func applyTheme(_ theme: AppTheme) {
        trackTintColor = theme.trackTintColor
        
    }
}

class DMCSwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTheming()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DMCSwitch: Themed {
    func applyTheme(_ theme: AppTheme) {
        onTintColor = theme.textColor
        
    }
}
