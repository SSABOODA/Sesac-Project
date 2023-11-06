//
//  SeriesCollectionReusableView.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/16.
//

import UIKit

class SeriesCollectionReusableView: UICollectionReusableView {

    
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var episodeCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        designReusableView()
    }
    
    func configureReusableView(_ row: Season) {
        seasonLabel.text = "\(row.name)"
        episodeCountLabel.text = "(\(row.episodeCount)개 회차)"
    }
    
    func designReusableView() {
        seasonLabel.font = .boldSystemFont(ofSize: 15)
        episodeCountLabel.font = .systemFont(ofSize: 13)
        episodeCountLabel.textColor = .gray
    }
}
