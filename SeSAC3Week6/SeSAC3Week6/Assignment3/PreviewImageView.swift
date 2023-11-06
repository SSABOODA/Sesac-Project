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
        print("CustomView" , frame.width, frame)
        
        layer.masksToBounds = true
        clipsToBounds = true
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 3
        contentMode = .scaleAspectFill
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        print(#function, frame.width, frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function, frame.width, frame)
        layer.cornerRadius = frame.width / 2
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        print(#function)
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        print(#function)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print(#function)
    }
    
    override func setNeedsUpdateConstraints() {
        super.setNeedsUpdateConstraints()
        print(#function)
    }
    
    override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        print(#function)
    }
    
}
