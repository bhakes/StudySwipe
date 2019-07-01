//
//  AlertChildPageViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

@objc public class AlertChildPageViewController: UIViewController {
    
    var pageIndex: Int!
    
    @objc @IBOutlet public private(set) weak var image: UIImageView!
    @objc @IBOutlet public private(set) weak var labelMainTitle: UILabel!
    @objc @IBOutlet public private(set) weak var labelDescription: UITextView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

