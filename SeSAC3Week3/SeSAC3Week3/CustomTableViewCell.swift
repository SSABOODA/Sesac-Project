//
//  CustomTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    @IBOutlet var backView: UIView!
    @IBOutlet var checkboxImageView: UIImageView!
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitelLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() { // cell의 viewDidLoad같은 개념?
        super.awakeFromNib()
        
        mainTitleLabel.font = .boldSystemFont(ofSize: 17)
        mainTitleLabel.textColor = .brown
    }
    
    // static func -> override class
    override class func awakeFromNib() {
        //
    }
    
    
    
    func configureCell(row: ToDo) {
        
        backView.backgroundColor = row.color
        mainTitleLabel.text = row.main
        subTitelLabel.text = row.sub
        
        checkboxImageView.image = row.done ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        
        var likeImage: UIImage?
        likeImage = row.like ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        likeButton.setImage(likeImage, for: .normal)
    }
    
}
