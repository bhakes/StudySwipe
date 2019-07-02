//
//  ReviewViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, ReviewSelectionTableViewDelegate {
    
    var tableViewContainerView: UIView!
    var tableViewContainerConstraint: NSLayoutConstraint!
    var tableViewController: ReviewSelectionTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateTableViewOut()
    }
    
    private func setupViews() {
        tableViewContainerView = UIView()
        tableViewContainerView.backgroundColor = .gray
        tableViewContainerView.constrainToSuperView(view, leading: 0, trailing:0, equalHeight: 0)
        tableViewContainerConstraint = tableViewContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        tableViewContainerConstraint.isActive = true
        
        
        tableViewController = ReviewSelectionTableViewController()
        tableViewController.delegate = self
        add(tableViewController, toView: tableViewContainerView)
    }
    
    private func animateTableViewOut() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewContainerConstraint.constant -= 800
            self.view.layoutIfNeeded()
        })
    }
}
