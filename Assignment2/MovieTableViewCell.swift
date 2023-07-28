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
    
    func configureCell(row: Movie) {
        movieImageView.image = UIImage(named: row.title)
        mainTitleLabel.text = row.title
        subTitleLabel.text = "\(row.releaseDate) | \(row.runtime)분 | \(row.rate)점"
        descriptionLabel.text = row.overview
    }
    
    func designCell() {
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
    }
}
