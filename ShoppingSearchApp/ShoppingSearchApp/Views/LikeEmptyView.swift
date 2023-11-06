//
//  LikeEmptyView.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/10.
//

import UIKit
import SnapKit

class LikeEmptyView: BaseView {
    
    private let likeEmptyImageView = {
        let view = UIImageView()
        view.image = Constants.ImageName.isNotLikeImageName
        view.tintColor = Constants.EmptyViewColor.tintColor
        return view
    }()

    private let likeEmptyLabel = {
        let view = UILabel()
        view.text = Constants.EmptyViewText.likeEmptyViewText
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = Constants.EmptyViewColor.textColor
        return view
    }()

    override func configureView() {
        addSubview(likeEmptyImageView)
        addSubview(likeEmptyLabel)
        isUserInteractionEnabled = false
    }
    
    override func setConstraints() {
        likeEmptyImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        likeEmptyLabel.snp.makeConstraints { make in
            make.top.equalTo(likeEmptyImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
}

