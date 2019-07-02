//
//  WalkthroughViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, AlertOnboardingDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfAlerts = [alert1, alert2, alert3, alert4]
        alertView = AlertOnboarding(arrayOfAlerts: arrayOfAlerts)
        alertView.delegate = self
        setupOnboarding()
        setupBottomControls()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertView.show()
    }
    
    //MARK:- Onboarding Properties
    
    var alertView: AlertOnboarding!
    var arrayOfAlerts = [Alert]()
    
    let alert1 = Alert(image: UIImage(named: "AppIcon")!, title: "StudySwipe", text: "Some text about title 1")
    let alert2 = Alert(image: UIImage(named: "AppIcon")!, title: "Title2", text: "Some text about title 2")
    let alert3 = Alert(image: UIImage(named: "AppIcon")!, title:  "Title3", text: "Some text about title 3")
    let alert4 = Alert(image: UIImage(named: "AppIcon")!, title:  "Title4", text: "Some text about title 4")
    
    
    // MARK: - Onboarding Private Methods
    
    private func setupOnboarding() {
        
        self.alertView.colorButtonText = .black
        self.alertView.colorButtonBottomBackground = .blue
        self.alertView.colorTitleLabel = .black
        self.alertView.colorDescriptionLabel = .black
        self.alertView.colorPageIndicator = UIColor(red: 173/255, green: 206/255, blue: 183/255, alpha: 1.0)
        self.alertView.colorCurrentPageIndicator = .blue
        
    }
    
    private func setupBottomControls(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [/*previousButton, pageControl, nextButton*/])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - IBActions
    
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        return pc
    }()
    
    // MARK: Onboarding Delegeate Methods
    
    
    func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
        print("Onboarding skipped the \(currentStep) step and the max step he saw was the number \(maxStep)")
    }
    
    func alertOnboardingCompleted() {
        print("Onboarding completed!")
    }
    
    func alertOnboardingNext(_ nextStep: Int) {
        print("Next step triggered! \(nextStep)")
    }
    
}

extension WalkthroughViewController {
    
    // Change the name of the storyboard if this is not "Main"
    // identifier is the Storyboard ID that you put juste before
    class func instantiate() -> WalkthroughViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewControllerSB") as! WalkthroughViewController
        
        return viewController
    }
    
}

