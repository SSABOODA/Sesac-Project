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
        tamagotchiNameLabel.designNameTag()
    }

    // cell 구성
    func configureCell(_ row: Tamagotchi) {
        tamagotchiImageView.image = UIImage(named: row.imageName)
        tamagotchiNameLabel.text = row.name
    }

}
