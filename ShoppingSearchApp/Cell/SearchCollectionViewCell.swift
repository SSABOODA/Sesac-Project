//
//  SearchViewCollectionViewCell.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit
import RealmSwift

final class SearchCollectionViewCell: BaseCollectionViewCell {
    private let mainImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var likeButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.tintColor = .black
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        return view
    }()
    
    private let labelView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let mallLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 11)
        view.textColor = .lightGray
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 12)
        view.textColor = .white
        return view
    }()
    
    private let priceLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textColor = .white
        return view
    }()
    
    var tasks: Results<ProductTable>!
    
    override func configureView() {
        super.configureView()
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
            make.top.equalToSuperview().offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
        likeButton.clipsToBounds = true
    }
    
    func configureCell(_ row: Item) {
        let url = URL(string: row.image)
        DispatchQueue.global().async {
            if let url = url, let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                }
            }
        }
        
        configure(
            mallName: row.mallName,
            title: row.title,
            price: row.lprice.convertNumberFormatStyleToDecimal(),
            isLike: row.isLike
        )
    }
    
    func configureCell(_ row: ProductTable) {
        guard let imageData = row.image else { return }
        guard let image = UIImage(data: imageData) else { return }
        self.mainImageView.image = image
        configure(
            mallName: row.mallName,
            title: row.title,
            price: row.price.convertNumberFormatStyleToDecimal(),
            isLike: row.isLike
        )
    }
    
    func configure(mallName: String, title: String, price: String, isLike: Bool) {
        
        mallLabel.text = mallName
        titleLabel.text = title.removeHtmlTag()
        priceLabel.text = price
        
        if isLike {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
}
