//
//  BookCollectionViewCell.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    
    func designCell(_ color: UIColor) {
        self.backgroundColor = color
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func configureCell(row: Movie) {
        titleLabel.text = row.title
        mainImageView.image = UIImage(named: row.title)
        rateLabel.text = "\(row.rate)"
    }
}
