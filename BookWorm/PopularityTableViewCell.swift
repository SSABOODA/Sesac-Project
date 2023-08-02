//
//  PopularityTableViewCell.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/08/02.
//

import UIKit

class PopularityTableViewCell: UITableViewCell {
    
    static let identifier = "PopularityTableViewCell"

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.backgroundColor = .clear
        mainImageView.layer.cornerRadius = 10
        mainImageView.clipsToBounds = true
    }
    
    
    func configureCell(_ row: Movie) {
        mainImageView.image = UIImage(named: row.title)
        titleLabel.text = row.title
        subTitleLabel.text = row.lookAroundSubTitle
    }
    
}
