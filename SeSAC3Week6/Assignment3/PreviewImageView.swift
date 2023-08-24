//
//  PreviewImageView.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit

class PreviewImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureView() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        clipsToBounds = true
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 3
        contentMode = .scaleAspectFill
        
    }
    
}
