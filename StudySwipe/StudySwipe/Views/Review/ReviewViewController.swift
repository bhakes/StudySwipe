//
//  ReviewViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, ReviewSelectionCollectionViewDelegate {
    
    static let animationDistance: CGFloat = 900
    
    var collectionViewContainer: UIView!
    var collectionViewContainerConstraint: NSLayoutConstraint!
    var collectionViewController: ReviewSelectionCollectionViewController!
    var testViewContainer: UIView!
    var testViewContainerConstraint: NSLayoutConstraint!
    var testViewController: TestViewController!
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, difficulty: Difficulty?, category: Category?) {
        let testTitle = category?.title() ?? difficulty?.title()
        let difficulty = difficulty ?? .All
        let category = category ?? .All
        collectionView.deselectItem(at: indexPath, animated: true)
        let test = coreDataFetchController.makeTest(with: "New Review", difficulties: [difficulty], categories: [category])
        
        
        testViewController = TestViewController()
        testViewController.test = test
        testViewController.dismissButtonTitle = "Dismiss"
        testViewController.testTitle = testTitle
        testViewController.closeButtonAction = { [weak self] in
            self?.animateTableViewIn()
        }
        add(testViewController, toView: testViewContainer)
        animateTableViewOut()
    }
    
    private func setupViews() {
        
        
        // Set up header view and title label
        let headerHeight: CGFloat = 80
        let headerView = DMCView()
        headerView.constrainToSuperView(view, centerX: 0, equalWidth: 0, height: headerHeight)
        
        let label = DMCLabel()
        label.text = "Pick a topic"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        
        label.constrainToSuperView(headerView, safeArea: false, top: 20, leading: 20, trailing: 20)
        
        // Set up collection view and container
        collectionViewContainer = DMCView()
        collectionViewContainer.backgroundColor = .gray
        collectionViewContainer.constrainToSuperView(view, leading: 0, trailing:0, equalHeight: -headerHeight)
        collectionViewContainerConstraint = collectionViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        collectionViewContainerConstraint.isActive = true
        headerView.constrainToSiblingView(collectionViewContainer, above: 0)

        collectionViewController = ReviewSelectionCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewController.delegate = self
        add(collectionViewController, toView: collectionViewContainer)
        
        // Set up test view container
        testViewContainer = UIView()
        
        testViewContainer.constrainToSuperView(view, leading: 0, trailing: 0, equalHeight: 0)
        testViewContainerConstraint = testViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ReviewViewController.animationDistance)
        testViewContainerConstraint.isActive = true
    
    
    }
    
    
    private func animateTableViewOut() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionViewContainerConstraint.constant -= ReviewViewController.animationDistance
            self.testViewContainerConstraint.constant -= ReviewViewController.animationDistance
            self.view.layoutIfNeeded()
        })
    }
    
    private func animateTableViewIn() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionViewContainerConstraint.constant += ReviewViewController.animationDistance
            self.testViewContainerConstraint.constant += ReviewViewController.animationDistance
            self.view.layoutIfNeeded()
        }) { _ in
            self.testViewController.remove()
            self.testViewController = nil
        }
    }
}

extension ReviewViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        
//        navigationBar.barTintColor = theme.barBackgroundColor
//        navigationBar.tintColor = theme.barForegroundColor
//        navigationBar.titleTextAttributes = [
//            NSAttributedStringKey.foregroundColor: theme.barForegroundColor
//        ]
    }
}
