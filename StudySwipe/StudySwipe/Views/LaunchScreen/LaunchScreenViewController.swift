//
//  LaunchScreenViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/11/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logoImageView.layer.cornerRadius = 20
        logoImageView.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var logoImageView: UIImageView!
    
}
