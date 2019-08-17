//
//  PerformanceViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController {
    
    static let animationDistance: CGFloat = 800
    
    var tableViewContainer: UIView!
    var tableViewContainerConstraint: NSLayoutConstraint!
    var tableViewController: PerformanceTableViewController!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBadge()
    }
    
    private func setupViews() {
    
        updateBadge()
        
        let headerHeight: CGFloat = 80
        let headerView = DMCView()
        headerView.constrainToSuperView(view, centerX: 0, equalWidth: 0, height: headerHeight)
        
        let label = UILabel.label(for: .title, with: "Track")
        label.constrainToSuperView(headerView, safeArea: false, top: 20, leading: 20, trailing: 20)
        
        tableViewContainer = DMCView()
        tableViewContainer.constrainToSuperView(view, leading: 0, trailing:0, equalHeight: -headerHeight)
        tableViewContainerConstraint = tableViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        tableViewContainerConstraint.isActive = true
        headerView.constrainToSiblingView(tableViewContainer, above: 0)
        
        tableViewController = PerformanceTableViewController(style: .grouped)
        add(tableViewController, toView: tableViewContainer)
        
    }
    
    private func updateBadge() {
        if let pVC = tabBarController as? DMCTabBarController {
            pVC.tabBar.items?[2].badgeValue = nil
            setMasteryUpdatesToUserDefaults(nil)
        }
    }

}

extension PerformanceViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = theme.backgroundColor

    }
}
