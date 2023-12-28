//
//  TrendPersonTableViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/09/01.
//

import UIKit

class TrendPersonTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ rowData: Movie) {
    }

}
