//
//  SearchViewCollectionViewCell.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    private let mainImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var likeButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.tintColor = .black
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        return view
    }()
    
    private let labelView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private let mallLabel = {
        let view = UILabel()
        view.backgroundColor = .cyan
        view.text = "123"
        view.font = .systemFont(ofSize: 11)
        view.textColor = .darkGray
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.backgroundColor = .orange
        view.numberOfLines = 2
        view.text = "123123123123"
        view.font = .systemFont(ofSize: 12)
        view.textColor = .white
        return view
    }()
    
    private let priceLabel = {
        let view = UILabel()
        view.backgroundColor = .yellow
        view.text = "123123123123123123123123123123123123123123123123"
        view.font = .boldSystemFont(ofSize: 13)
        view.textColor = .white
        return view
    }()
    
    override func configureView() {
        addSubview(mainImageView)
        addSubview(labelView)
        mainImageView.addSubview(likeButton)
        labelView.addSubview(mallLabel)
        labelView.addSubview(titleLabel)
        labelView.addSubview(priceLabel)
    }
    
    override func setConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(30)
        }
        
        //
        labelView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        mallLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
        likeButton.clipsToBounds = true
    }
}

