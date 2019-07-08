//
//  PerformanceViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController, PerformanceTableViewDelegate {
    

    static let animationDistance: CGFloat = 800
    
    var tableViewContainer: UIView!
    var tableViewContainerConstraint: NSLayoutConstraint!
    var tableViewController: PerformanceTableViewController!
    
    let coreDataFetchController = CoreDataFetchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        let headerHeight: CGFloat = 80
        let headerView = UIView()
        headerView.constrainToSuperView(view, centerX: 0, equalWidth: 0, height: headerHeight)
        
        let label = UILabel()
        label.text = "Performance"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        
        label.constrainToSuperView(headerView, safeArea: false, top: 20, leading: 20, trailing: 20)
        
        tableViewContainer = UIView()
        tableViewContainer.backgroundColor = .gray
        tableViewContainer.constrainToSuperView(view, leading: 0, trailing:0, equalHeight: -headerHeight)
        tableViewContainerConstraint = tableViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        tableViewContainerConstraint.isActive = true
        headerView.constrainToSiblingView(tableViewContainer, above: 0)
        
        tableViewController = PerformanceTableViewController(style: .grouped)
        tableViewController.delegate = self
        add(tableViewController, toView: tableViewContainer)
        
    }

}
