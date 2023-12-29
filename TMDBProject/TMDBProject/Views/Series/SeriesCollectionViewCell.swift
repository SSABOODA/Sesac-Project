//
//  SeriesCollectionViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/16.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var blurImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var episodeLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        designCell()
        setBlurEffect()
    }
    
    private func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = blurImageView.bounds;
        blurImageView.addSubview(blurView)
    }

  
    func configureCell(_ row: Episode) {
        if let imageURL = URL(string: row.fullImageURL) {
            [
                posterImageView,
                blurImageView,
            ].forEach { image in
                image.kf.indicatorType = .activity
                image.kf.setImage(with: imageURL)
            }
        }
        episodeLabel.text = "\(row.episodeNumber)"
        titleLabel.text = row.name
        runtimeLabel.text = "\(row.runtime ?? 0)분"
        overviewLabel.text = row.overview
    }
    
    func designCell() {
        posterImageView.contentMode = .scaleAspectFill
        titleLabel.font = .boldSystemFont(ofSize: 13)
        titleLabel.numberOfLines = 2
        
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
        
        blurImageView.layer.cornerRadius = 15
        blurImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        posterImageView.image = nil
        episodeLabel.text = nil
        titleLabel.text = nil
        runtimeLabel.text = nil
        overviewLabel.text = nil
        blurImageView.image = nil
    }
}
