//
//  ReviewSelectionCollectionViewDelegate.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/3/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

protocol ReviewSelectionCollectionViewDelegate: class {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, difficulty: Difficulty?, category: Category?)
}

extension ReviewSelectionCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, difficulty: Difficulty?, category: Category?) {
        return
    }
}
