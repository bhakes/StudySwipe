//
//  SettingsViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/12/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, SettingsTableViewDelegate {
    
    
    static let animationDistance: CGFloat = 800
    
    var tableViewContainer: UIView!
    var tableViewContainerConstraint: NSLayoutConstraint!
    var tableViewController: SettingsTableViewController!
    
    let coreDataFetchController = CoreDataFetchController()
    
    private var themedStatusBarStyle: UIStatusBarStyle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themedStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setUpTheming()
    }
    
    private func setupViews() {
        
        let headerHeight: CGFloat = 80
        let headerView = DMCView()
        headerView.constrainToSuperView(view, centerX: 0, equalWidth: 0, height: headerHeight)
        
        let label = UILabel.label(for: .title, with: "Settings")
        label.constrainToSuperView(headerView, safeArea: false, top: 20, leading: 20, trailing: 20)
        
        tableViewContainer = DMCView()
        tableViewContainer.constrainToSuperView(view, leading: 0, trailing:0, equalHeight: -headerHeight)
        tableViewContainerConstraint = tableViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        tableViewContainerConstraint.isActive = true
        headerView.constrainToSiblingView(tableViewContainer, above: 0)
        
        tableViewController = SettingsTableViewController(style: .grouped)
        tableViewController.delegate = self
        add(tableViewController, toView: tableViewContainer)
        
    }
    
}

extension SettingsViewController: DarkModeCellDelegate {
    func darkModeDidChange() {
        self.view.setNeedsLayout()
        self.view.setNeedsDisplay()
    }
    
    
}


extension SettingsViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = theme.backgroundColor

    }
}
