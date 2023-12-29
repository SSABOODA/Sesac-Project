//
//  SimilarCollectionViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/19.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var blurImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.designCell()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = blurImageView.bounds;
        blurImageView.addSubview(blurView)
    }
    
    func configureVideo(_ row: Video) {
        let urlString = "https://img.youtube.com/vi/\(row.key)/0.jpg"
        if let imageURL = URL(string: urlString) {
            [
                moviePosterImageView,
                blurImageView,
            ].forEach { image in
                image.kf.indicatorType = .activity
                image.kf.setImage(with: imageURL)
            }
        }
        movieTitleLabel.text = row.name
    }
    
    func configureSimilarVideo(_ row: SimilarMovie) {
        if let imageURL = URL(string: row.fullImageURL) {
            [
                moviePosterImageView,
                blurImageView,
            ].forEach { image in
                image.kf.indicatorType = .activity
                image.kf.setImage(with: imageURL)
            }
        }
        movieTitleLabel.text = row.title
    }
    
    func designCell() {
        movieTitleLabel.font = .boldSystemFont(ofSize: 13)
        moviePosterImageView.contentMode = .scaleAspectFill
        moviePosterImageView.layer.cornerRadius = 15
        moviePosterImageView.clipsToBounds = true
        backView.backgroundColor = .clear
        backView.layer.cornerRadius = 15
        backView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
        movieTitleLabel.text = nil
        blurImageView.image = nil
    }
}
