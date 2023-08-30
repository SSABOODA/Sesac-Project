//
//  SearchCollectionViewCell.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleToFill
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureCell(row: UnsplashDataList) {
        let imageURL = row.urls.thumb
        if let imageURL = URL(string: imageURL) {
            imageView.kf.setImage(with: imageURL)
        }
        
    }
    
}
