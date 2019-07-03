//
//  UIAlertController+StandardAlerts.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func informationalAlertController(title: String? = "Error", message: String?, dismissTitle: String = "Dismiss", dismissActionCompletion: ((UIAlertAction) -> Void)? = nil,  withCancel: Bool = false, cancelActionCompletion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissTitle, style: .default, handler: dismissActionCompletion)
        
        alertController.addAction(dismissAction)
        
        if withCancel {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelActionCompletion)
            alertController.addAction(cancelAction)
        }
        
        return alertController
    }
}
