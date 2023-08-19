//
//  SimilarCollectionViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/19.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }
    
    
    func configureCell(_ row: Video) {
        let urlString = "https://img.youtube.com/vi/\(row.key)/0.jpg"
        let fileURL = URL(string: urlString)
        moviePosterImageView.kf.setImage(with: fileURL)
        movieTitleLabel.text = row.name
    }
    
    func designCell() {
        movieTitleLabel.font = .boldSystemFont(ofSize: 13)
    }
    

}
