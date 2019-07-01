//
//  AlertOnboardingDelegate.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

@objc public protocol AlertOnboardingDelegate {
    func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int)
    func alertOnboardingCompleted()
    func alertOnboardingNext(_ nextStep: Int)
    
    @objc optional func alertOnboardingDidDisplayStep(alertOnboarding: AlertOnboarding, alertChildPageViewController: AlertChildPageViewController, step: Int)
}

