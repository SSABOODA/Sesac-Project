//
//  TrendTableViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import UIKit

class TrendTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var hashtagLabel: UILabel!
    
    @IBOutlet var mainCardView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var clipButton: UIButton!
    @IBOutlet var rateLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func configureCell() {
        dateLabel.text = "12/10/2022"
        hashtagLabel.text = "#Mystery"
        
        mainImageView.backgroundColor = .lightGray
        rateLabel.text = "3.3"
        
        titleLabel.text = "Alice in borderland"
        subTitleLabel.text = "Alice in borderland, Alice in borderland"
    }
    
    func designTableViewCell() {
        mainCardView
    }
    
    
}
