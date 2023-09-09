//
//  LikeViewController.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit

final class LikeViewController: BaseViewController {
    
    private let searchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.placeholder = "검색어를 입력해주세요"
        view.searchBar.scopeButtonTitles = ["맥북", "에어팟", "아이패드"]
        view.hidesNavigationBarDuringPresentation = false
        return view
    }()
    
    private lazy var collectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.collectionViewLayout()
        )
        view.delegate = self
        view.dataSource = self
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        view.collectionViewLayout = self.collectionViewLayout()
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.searchController = searchController
    }
    
    override func configureView() {
        title = Constants.TextContent.likeViewNavigationTitle
    }
    
    override func setConstraints() {
    }
}

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutCGFloat = Constants.ColletionViewLayoutDesign.self
        
        layout.minimumLineSpacing = layoutCGFloat.lineSpacing
        layout.minimumInteritemSpacing = layoutCGFloat.interItemSpacing
        let size = UIScreen.main.bounds.width - layoutCGFloat.remainWidthSize
        layout.itemSize = CGSize(
            width: size/layoutCGFloat.splitSize,
            height: UIScreen.main.bounds.width * 0.65
        )
        layout.sectionInset = UIEdgeInsets(
            top: layoutCGFloat.spacing,
            left: layoutCGFloat.spacing,
            bottom: layoutCGFloat.spacing,
            right: layoutCGFloat.spacing
        )
        return layout
    }
}
