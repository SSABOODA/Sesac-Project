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
        view.tintColor = Constants.EmptyViewColor.tintColor
        return view
    }()

    private let searchEmptyLabel = {
        let view = UILabel()
        view.text = Constants.EmptyViewText.searchEmptyViewText
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = Constants.EmptyViewColor.textColor
        return view
    }()

    override func configureView() {
        addSubview(searchEmptyImageView)
        addSubview(searchEmptyLabel)
        isUserInteractionEnabled = false
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
