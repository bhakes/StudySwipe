//
//  TestSummaryViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/27/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestSummaryViewController: UIViewController {
    
    var dismissHandler: (() -> Void)?
    
    var testObservation: InterviewTestObservation?
    
    var titleLabel: DMCLabel = {
        let label = UILabel.label(for: .title, with: "Summary")
        
        return label
    }()
    
    var dismissButton: UIButton = {
        let button = UIButton.button(for: .normal, with: "Okay")
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    private func setupViews() {
        view = DMCView()
        
        titleLabel.constrainToSuperView(view, top: 20, leading: 20, trailing: 20)
        
        dismissButton.constrainToSuperView(view, bottom: 20, centerX: 0, width: 120)
    }
    
    @objc func dismissView() {
        if let dismissHandler = dismissHandler {
            dismissHandler()
        } else {
            dismiss(animated: true)
        }
    }
}
