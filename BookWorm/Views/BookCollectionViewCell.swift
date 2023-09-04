//
//  BookCollectionViewCell.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit
import Kingfisher
import RealmSwift

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
        self.backgroundColor = UIColor.systemGray4
    }
    
    func configure(
        title: String,
        thumbnail: String,
        status: String,
        like: Bool
    ) {
        titleLabel.text = title
        
        if let imageURL = URL(string: thumbnail) {
            mainImageView.kf.setImage(with: imageURL)
        }
        
        rateLabel.text = "\(status)"
        
        if like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .white
        }
    }
    
    func configureCell(row: Book) {
        configure(title: row.title, thumbnail: row.thumbnail, status: row.status, like: row.like)
    }
    
    func configureCell(row: BookTable) {
        configure(title: row.title, thumbnail: row.thumbnail, status: row.status, like: row.like)
    }
}

