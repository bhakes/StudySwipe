//
//  ReviewSelectionCollectionViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol ReviewSelectionCollectionViewDelegate: class {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, difficulty: Difficulty?, category: Category?)
}

class ReviewSelectionCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    static let sectionNumber = 2
    
    weak var delegate: ReviewSelectionCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        collectionView.register(SelectionCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.backgroundColor = .white
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ReviewSelectionCollectionViewController.sectionNumber
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Category.allCases.count
        case 1:
            return Difficulty.allCases.count
        default:
            fatalError("There should only be \(ReviewSelectionTableViewController.sectionNumber) sections")
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SelectionCollectionViewCell else {
            fatalError("Check for typos.")
        }
    
        let item: ColorIconTitleProviding
        switch indexPath.section {
        case 0:
            item = Category.allCases[indexPath.row]
        case 1:
            item = Difficulty.allCases[indexPath.row]
        default:
            fatalError("There should only be \(ReviewSelectionTableViewController.sectionNumber) sections")
        }
        
        cell.item = item
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var category: Category?
        var difficulty: Difficulty?
        
        switch indexPath.section {
        case 0:
            category = Category.allCases[indexPath.row]
        case 1:
            difficulty = Difficulty.allCases[indexPath.row]
        default:
            fatalError("There should only be \(ReviewSelectionTableViewController.sectionNumber) sections")
        }
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath, difficulty: difficulty, category: category)
    }
    
    // MARK: - UI Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.width / 2) - 25
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
}