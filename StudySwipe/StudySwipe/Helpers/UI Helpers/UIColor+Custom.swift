//
//  UIColor+Custom.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let accentColor: UIColor = .categoryDefault2
    static let warningColor: UIColor = .categoryDefault1
    static let testBackground = UIColor(hex: "#33333B")!
    static let fadedTextColor: UIColor = .gray
    
    // MARK: - Category Colors
    static let swift = UIColor(hex: "#ED523F")!
    
    static let categoryDefault1 = UIColor(hex: "#D95058")!
    static let categoryDefault2 = UIColor(hex: "#0367A6")!
    static let categoryDefault3 = UIColor(hex: "#04BFBF")!
    static let categoryDefault4 = UIColor(hex: "#E570F5")!
    static let categoryDefault5 = UIColor(hex: "#F29F05")!
    
    
    // MARK: - Convenience Initializers
    /// Convenience initializer that returns a UIColor from HEX values
    convenience init(hexRed: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) {
        self.init(red: hexRed/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    /// Convenience initializer that returns a UIColor from a HEX string
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        // Make a character set that will strip whitespace and #'s
        var characterSet = CharacterSet.whitespacesAndNewlines
        characterSet.insert(charactersIn: "#")
        // Use it to format the hex string
        let cString = hex.components(separatedBy: characterSet).joined().uppercased()
        
        // For now, if it is not exactly 6 characters, return nil
        // TODO: Update to take a 3 character hex code
        if (cString.count != 6) { return nil }
        
        // Scan the hex number into an Int
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        // Do some fancy hex math and initialize a UIColor
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)
        let green = CGFloat((rgbValue & 0x00FF00) >> 8)
        let blue = CGFloat(rgbValue & 0x0000FF)
        self.init(hexRed: red, green: green, blue: blue, alpha: alpha)
    }
}
