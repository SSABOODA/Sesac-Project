//
//  SearchTableViewCell.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/6/23.
//

import UIKit
import RxSwift
import SnapKit

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    let starImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        return view
    }()
    
    let rateLabel = {
        let lb = UILabel()
        lb.text = "4.7"
        lb.textColor = .darkGray
        return lb
    }()
    
    let appCompanyNameLabel = {
        let lb = UILabel()
        lb.text = "Kakao Mobility Corp."
        lb.textColor = .darkGray
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 13)
        return lb
    }()
    
    let appCategoryLabel = {
        let lb = UILabel()
        lb.text = "여행"
        lb.textColor = .darkGray
        lb.font = UIFont.systemFont(ofSize: 13)
        return lb
    }()
    
    lazy var rateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            starImageView,
            rateLabel
        ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 5
        return sv
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            rateStackView,
            appCompanyNameLabel,
            appCategoryLabel
        ])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 10
        return sv
    }()
    
    let screenshot1 = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.backgroundColor = .systemMint
        v.contentMode = .scaleToFill
        return v
    }()
    let screenshot2 = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.backgroundColor = .systemMint
        v.contentMode = .scaleToFill
        return v
    }()
    let screenshot3 = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.backgroundColor = .systemMint
        v.contentMode = .scaleToFill
        return v
    }()
    
    lazy var screenshotStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            screenshot1,
            screenshot2,
            screenshot3
        ])
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fillEqually
        return sv
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appIconImageView)
        contentView.addSubview(downloadButton)
        contentView.addSubview(stackView)
        contentView.addSubview(screenshotStackView)
        
        stackView.addSubview(rateStackView)
        stackView.addSubview(appCompanyNameLabel)
        stackView.addSubview(appCategoryLabel)

        appIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(25)
        }
        
        rateStackView.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        screenshotStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
