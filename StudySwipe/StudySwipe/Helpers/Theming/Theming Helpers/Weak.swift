//
//  Weak.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/12/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

/// A box that allows us to weakly hold on to an object
struct Weak<Object: AnyObject> {
    weak var value: Object?
}
