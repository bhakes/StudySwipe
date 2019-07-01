//
//  SwipeableViewDelegate.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

protocol SwipeableViewDelegate: class {
    
    func didTap(view: SwipeableView)
    
    func didBeginSwipe(onView view: SwipeableView)
    
    func didEndSwipe(onView view: SwipeableView)
    
}
