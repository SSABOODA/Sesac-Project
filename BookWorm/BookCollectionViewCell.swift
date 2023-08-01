//
//  BookCollectionViewCell.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    
    func designCell(_ color: UIColor) {
        self.backgroundColor = color
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func configureCell(row: Movie) {
        titleLabel.text = row.title
        mainImageView.image = UIImage(named: row.title)
        rateLabel.text = "\(row.rate)"
        
        if row.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
