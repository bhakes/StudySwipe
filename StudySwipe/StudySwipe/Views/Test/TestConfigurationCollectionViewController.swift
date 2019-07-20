//
//  TestConfigurationCollectionViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/18/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let headerIdentifier = "HeaderCell"

class TestConfigurationCollectionViewController: UICollectionViewController {
    
    var selectedDifficulties: [Difficulty] = []
    var selectedCategories: [Category] = []
    
    var options: [[ColorIconTitleProviding]] {
        return [selectedCategories, selectedDifficulties]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(TestConfigurationCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.register(SelectionCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)

        collectionView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetSelection()
    }
    
    func resetSelection() {
        selectedCategories = Category.nonEmptyCategories.filter({ $0 != .All })
        selectedDifficulties = Difficulty.allCases.filter({ $0 != .All })
        
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return options.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options[section].count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TestConfigurationCollectionViewCell
        
        let item = options[indexPath.section][indexPath.row]
        
        cell.item = item
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        removeItem(at: indexPath)
        collectionView.deleteItems(at: [indexPath])
    }
    
    private func removeItem(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedCategories.remove(at: indexPath.row)
        case 1:
            selectedDifficulties.remove(at: indexPath.row)
        default:
            fatalError("There should only be two sections")
        }
    }
    
}
