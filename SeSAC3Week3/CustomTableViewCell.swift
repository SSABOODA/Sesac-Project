//
//  CustomTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var checkboxImageView: UIImageView!
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitelLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configureCell(row: ToDo) {
        mainTitleLabel.text = row.main
        subTitelLabel.text = row.sub
        
        checkboxImageView.image = row.done ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        
        var likeImage: UIImage?
        likeImage = row.like ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        likeButton.setImage(likeImage, for: .normal)
    }
    
    
    
    
    
    
}
