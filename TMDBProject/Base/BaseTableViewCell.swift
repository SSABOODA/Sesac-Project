//
//  BaseTableViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
