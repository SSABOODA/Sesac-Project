//
//  SearchDetailViewController.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class SearchDetailViewController: UIViewController {
    
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = {
        let view = UIView()
        return view
    }()
    
    let appInfoView = {
        let v = UIView()
        return v
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
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "KakaoMap - Korea NO.1 Map"
        label.numberOfLines = 1
        return label
    }()
    
    let appCompanyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .lightGray
        label.text = "Kakao Corp."
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let releaseView: UIView = {
        let v = UIView()
        return v
    }()
    
    let releaseInfoLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var viewModel = SearchDetailViewModel()
    var appInfo: ControlEvent<AppInfo>.Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureView()
//        print(appInfo)
    }
    
    private func configureView() {
        guard let info = appInfo else { return }
        if let imageURL = URL(string: info.artworkUrl512) {
            appIconImageView.kf.setImage(with: imageURL)
        }
        
        appNameLabel.text = info.trackName
        appCompanyNameLabel.text = info.sellerName
        releaseInfoLabel.text = info.releaseNotes
    }
    
    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(appInfoView)
        appInfoView.addSubview(appIconImageView)
        appInfoView.addSubview(appNameLabel)
        appInfoView.addSubview(appCompanyNameLabel)
        appInfoView.addSubview(downloadButton)
        
        contentView.addSubview(releaseView)
        releaseView.addSubview(releaseInfoLabel)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
            make.width.equalTo(scrollView)
        }
        
        appInfoView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(110)
        }
        
        appIconImageView.backgroundColor = .gray
        appIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(100)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.top).inset(10)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(13)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        appCompanyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).inset(-10)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(13)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(appCompanyNameLabel.snp.bottom).inset(-10)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(13)
            make.height.equalTo(32)
            make.width.equalTo(72)
        }
        
        releaseView.backgroundColor = .systemPink
        releaseView.snp.makeConstraints { make in
            make.top.equalTo(appInfoView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        releaseInfoLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(10)
        }
    }
}

extension SearchDetailViewController {
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
