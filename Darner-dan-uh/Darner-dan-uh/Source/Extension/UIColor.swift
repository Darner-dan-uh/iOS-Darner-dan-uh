//
//  UIColor.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/14.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

extension UIColor {
    static var customPink: UIColor {
        return rgb(red: 253, green: 125, blue: 128, alpha: 1)
    }
    
    static var customGray: UIColor {
        return rgb(red: 242, green: 242, blue: 242, alpha: 0.72)
    }
    
    static var customBlack: UIColor {
        return rgb(red: 95, green: 89, blue: 89, alpha: 1)
    }
    
    static func rgb(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return .init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
}

