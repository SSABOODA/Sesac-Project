//
//  BookCollectionViewCell.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var movie = MovieInfo()
    
    var bookList: [Book] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCommonCell()
    }
}

extension BookCollectionViewCell: CollectionViewCellProtocol {
    func designCommonCell() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func configureCell(row: Book) {
        self.backgroundColor = UIColor.systemGray4
        titleLabel.text = row.title
        
        if let imageURL = URL(string: row.thumbnail) {
            mainImageView.kf.setImage(with: imageURL)
        }
        
        rateLabel.text = "\(row.status)"
        
        if row.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .white
        }
    }
}

