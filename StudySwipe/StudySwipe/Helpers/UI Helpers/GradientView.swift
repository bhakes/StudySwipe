//
//  GradientView.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/7/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func setupGradient(startColor: UIColor = .white,
                       endColor: UIColor = .black,
                       startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
                       endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)) {
        backgroundColor = .clear
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}
