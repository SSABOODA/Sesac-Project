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
        view.tintColor = .white
        return view
    }()

    private let likeEmptyLabel = {
        let view = UILabel()
        view.text = "좋아요한 상품이 없습니다."
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()

    override func configureView() {
        addSubview(likeEmptyImageView)
        addSubview(likeEmptyLabel)
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

