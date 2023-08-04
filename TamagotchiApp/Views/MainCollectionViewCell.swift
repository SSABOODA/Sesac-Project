//
//  MainCollectionViewCell.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var tamagotchiNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designLabel()
    }
    
    
    func designLabel() {
        tamagotchiNameLabel.layer.borderWidth = 1
        tamagotchiNameLabel.layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
        tamagotchiNameLabel.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        tamagotchiNameLabel.layer.cornerRadius = 3
        tamagotchiNameLabel.clipsToBounds = true
        tamagotchiNameLabel.font = .boldSystemFont(ofSize: 11)

    }

    // cell 구성
    func configureCell(_ row: Tamagotchi) {
        tamagotchiImageView.image = UIImage(named: row.imageName)
        tamagotchiNameLabel.text = row.name
    }

}
