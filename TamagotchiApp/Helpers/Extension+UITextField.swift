//
//  Extension+UITextField.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/05.
//

import UIKit

extension UITextField {
    func designTextField() {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(0.9)
        border.frame = CGRect(
            x: 0,
            y: self.frame.size.height-width,
            width: self.frame.size.width,
            height: self.frame.size.height
        )
//        border.backgroundColor = UIColor.systemGray2.cgColor
        border.backgroundColor = ColorData().fontColor.cgColor
        self.layer.addSublayer(border)
        self.textAlignment = .center
        self.textColor = UIColor.systemGray2
        self.layer.masksToBounds = true
    }
}

