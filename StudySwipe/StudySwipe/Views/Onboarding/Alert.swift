//
//  Alert.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

@objc public class Alert: NSObject {
    var image: UIImage
    var title: String
    var text: String
    
    @objc public init(image: UIImage, title: String, text: String) {
        self.image = image
        self.title = title
        self.text = text
    }
}

