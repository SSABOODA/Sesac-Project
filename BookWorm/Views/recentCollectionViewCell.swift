//
//  recentCollectionViewCell.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/08/02.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecentCollectionViewCell"
    
    @IBOutlet var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCommonCell()
    }
}

extension RecentCollectionViewCell: CollectionViewCellProtocol {
    func designCommonCell() {
        mainImageView.layer.cornerRadius = 10
        mainImageView.clipsToBounds = true
    }
    
    func configureCell(_ row: Movie) {
        mainImageView.image = UIImage(named: row.title)
    }
}
