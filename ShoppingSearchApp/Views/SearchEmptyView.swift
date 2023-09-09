//
//  SearchEmptyView.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/10.
//

import UIKit
import SnapKit


class SearchEmptyView: BaseView {
    private let searchEmptyImageView = {
        let view = UIImageView()
        view.image = Constants.ImageName.searchViewTabBarSystemSelectImage
        view.tintColor = .white
        return view
    }()

    private let searchEmptyLabel = {
        let view = UILabel()
        view.text = "상품을 검색해보세요."
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()

    override func configureView() {
        addSubview(searchEmptyImageView)
        addSubview(searchEmptyLabel)
    }
    
    override func setConstraints() {
        searchEmptyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.size.equalTo(50)
        }
        
        searchEmptyLabel.snp.makeConstraints { make in
            make.top.equalTo(searchEmptyImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }

}
