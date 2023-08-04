//
//  Extension+UILabel.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit


extension UILabel {
    func designNameTag() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
        self.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        self.font = .boldSystemFont(ofSize: 11)
    }
}
