//
//  UIColor.swift
//  CineTime
//
//  Created by Beatriz Carlos on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let actionColor = UIColor(red: 1.00, green: 0.86, blue: 0.38, alpha: 1.00)
    static let primaryColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    
    
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var rgbValue: UInt64 = 0

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
        return
    }
}
