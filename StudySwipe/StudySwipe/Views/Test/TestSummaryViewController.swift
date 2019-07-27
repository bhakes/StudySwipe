//
//  TestSummaryViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/27/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestSummaryViewController: UIViewController {
    
    var testObservation: InterviewTestObservation?
    
    var titleLabel: UILabel = {
        let label = UILabel.label(for: .title, with: "Summary")
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        view = DMCView()
        
        titleLabel.constrainToSuperView(view, top: 20, leading: 20, trailing: 20)
        
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
