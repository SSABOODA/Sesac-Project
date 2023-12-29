//
//  DetailTableViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/12.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    
    @IBOutlet var castImageView: UIImageView!
    @IBOutlet var realNameLabel: UILabel!
    @IBOutlet var castNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }

    func designCell() {
        castImageView.backgroundColor = .white
        castImageView.contentMode = .scaleToFill
        castImageView.layer.cornerRadius = 10
        castImageView.clipsToBounds = true
        realNameLabel.font = .boldSystemFont(ofSize: 13)
        castNameLabel.font = .systemFont(ofSize: 11)
    }
    
    func configureCell(_ rowData: Cast) {
        if let imageURL = URL(string: rowData.fullImageURL) {
            [
                castImageView,
            ].forEach { image in
                image.kf.indicatorType = .activity
                image.kf.setImage(with: imageURL)
            }
            
        }
        realNameLabel.text = rowData.name
        castNameLabel.text = rowData.subTitleText
    }

}
