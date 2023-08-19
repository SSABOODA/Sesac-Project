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
    
    
    func configureVideo(_ row: Video) {
        let urlString = "https://img.youtube.com/vi/\(row.key)/0.jpg"
        let fileURL = URL(string: urlString)
        moviePosterImageView.kf.setImage(with: fileURL)
        movieTitleLabel.text = row.name
    }
    
    func configureSimilarVideo(_ row: SimilarMovie) {
        if let imageURL = URL(string: row.fullImageURL) {
            moviePosterImageView.kf.setImage(with: imageURL)
        }
        movieTitleLabel.text = row.title
    }
    
    func designCell() {
        movieTitleLabel.font = .boldSystemFont(ofSize: 13)
        moviePosterImageView.contentMode = .scaleAspectFill
    }
    

}
