//
//  MovieTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/28.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = Identifier.movieCell.rawValue
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    
    func configureCell(row: Movie) {
        movieImageView.image = UIImage(named: row.title)
        mainTitleLabel.text = row.title
        subTitleLabel.text = "\(row.releaseDate) | \(row.runtime)분 | \(row.rate)점"
        descriptionLabel.text = row.overview
        
        if row.like {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .white
        }
    }
    
    func designCell() {
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
    }
}
