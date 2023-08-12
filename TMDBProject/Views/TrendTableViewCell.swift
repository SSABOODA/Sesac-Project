//
//  TrendTableViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import UIKit
import Kingfisher

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

    
    func configureCell(_ rowData: Movie) {
        print(rowData)
        dateLabel.text = rowData.convertData
        hashtagLabel.text = "#\(rowData.mediaType)"
        mainImageView.backgroundColor = .lightGray
        if let imageURL = URL(string: rowData.imageURL) {
            mainImageView.kf.setImage(with: imageURL)
        }
        rateLabel.text = rowData.roundRate
        titleLabel.text = rowData.title
        subTitleLabel.text = rowData.description
    }
    
    func designTableViewCell() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.backgroundColor = .clear
        mainImageView.layer.cornerRadius = 20
        mainCardView.clipsToBounds = true

        mainCardView.backgroundColor = .white
        mainCardView.layer.cornerRadius = 20
        mainCardView.layer.shadowColor = UIColor.black.cgColor
        mainCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainCardView.layer.shadowRadius = 15
        mainCardView.layer.shadowOpacity = 0.5
        mainCardView.clipsToBounds = false
        
        clipButton.layer.cornerRadius = clipButton.frame.width / 2
        clipButton.clipsToBounds = true
        clipButton.backgroundColor = .white
        clipButton.tintColor = .black
        
        
        
    }
    
    
}
