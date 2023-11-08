//
//  AppScreenshotImageView.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/8/23.
//

import UIKit

class AppScreenshotImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .systemMint
        contentMode = .scaleToFill
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
