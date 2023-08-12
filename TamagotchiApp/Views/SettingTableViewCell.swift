//
//  SettingTableViewCell.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/12.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }

    
    func configureCell(_ indexPathRow: Int) {
        textLabel?.text = SettingTableViewTiTle.allCases[indexPathRow].rawValue
        imageView?.image = UIImage(systemName: SettingTableViewImage.allCases[indexPathRow].rawValue)
        detailTextLabel?.text = (indexPathRow == 0) ? UserDefaultsHelper.shared.nickname : ""
    }
    
    func designCell() {
        imageView?.tintColor = .lightGray
        backgroundColor = ColorData.backgroundColor
        
        textLabel?.font = .boldSystemFont(ofSize: 13)
        textLabel?.textColor = .black
    }
}
