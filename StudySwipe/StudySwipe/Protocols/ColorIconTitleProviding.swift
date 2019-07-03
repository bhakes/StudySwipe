//
//  ColorIconTitleProviding.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/3/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

protocol ColorProviding {
    func color() -> UIColor
}

protocol IconProviding {
    func icon() -> UIImage
}

protocol TitleProviding {
    func title() -> String
}

typealias ColorIconTitleProviding = ColorProviding & IconProviding & TitleProviding
