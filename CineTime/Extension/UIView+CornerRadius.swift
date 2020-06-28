//
//  UIView+CornerRadius.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 26/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
