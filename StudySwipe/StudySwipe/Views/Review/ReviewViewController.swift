//
//  ReviewViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, ReviewSelectionTableViewDelegate {
    
    static let animationDistance: CGFloat = 800
    
    var tableViewContainer: UIView!
    var tableViewContainerConstraint: NSLayoutConstraint!
    var tableViewController: ReviewSelectionTableViewController!
    var testViewContainer: UIView!
    var testViewContainerConstraint: NSLayoutConstraint!
    var testViewController: TestViewController!
    
    let coreDataFetchController = CoreDataFetchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, difficulty: Difficulty?, category: Category?) {
        let difficulty = difficulty ?? .All
        let category = category ?? .All
        tableView.deselectRow(at: indexPath, animated: true)
        let test = coreDataFetchController.makeTest(with: "New Review", difficulties: [difficulty], categories: [category])
        
        testViewController = TestViewController()
        testViewController.test = test
        testViewController.dismissButtonTitle = "Dismiss"
        testViewController.closeButtonAction = { [weak self] in
            self?.animateTableViewIn()
        }
        add(testViewController, toView: testViewContainer)
        animateTableViewOut()
    }
    
    private func setupViews() {
        tableViewContainer = UIView()
        tableViewContainer.backgroundColor = .gray
        tableViewContainer.constrainToSuperView(view, leading: 0, trailing:0, equalHeight: 0)
        tableViewContainerConstraint = tableViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        tableViewContainerConstraint.isActive = true
        
        
        tableViewController = ReviewSelectionTableViewController()
        tableViewController.delegate = self
        add(tableViewController, toView: tableViewContainer)
        
        testViewContainer = UIView()
        testViewContainer.constrainToSuperView(view, leading: 0, trailing: 0, equalHeight: 0)
        testViewContainerConstraint = testViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ReviewViewController.animationDistance)
        testViewContainerConstraint.isActive = true
    }
    
    private func animateTableViewOut() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewContainerConstraint.constant -= ReviewViewController.animationDistance
            self.testViewContainerConstraint.constant -= ReviewViewController.animationDistance
            self.view.layoutIfNeeded()
        })
    }
    
    private func animateTableViewIn() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewContainerConstraint.constant += ReviewViewController.animationDistance
            self.testViewContainerConstraint.constant += ReviewViewController.animationDistance
            self.view.layoutIfNeeded()
        }) { _ in
            self.testViewController.remove()
            self.testViewController = nil
        }
    }
}
