//
//  LikeViewController.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit
import SnapKit
import RealmSwift
import Toast

final class LikeViewController: BaseViewController {
    
    private lazy var searchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.placeholder = "검색어를 입력해주세요"
        view.searchBar.scopeButtonTitles = ["맥북", "에어팟", "아이패드"]
        view.hidesNavigationBarDuringPresentation = false
        view.searchBar.tintColor = .white
        view.searchResultsUpdater = self
        view.searchBar.delegate = self
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.collectionViewLayout()
        )
        view.delegate = self
        view.dataSource = self
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        view.collectionViewLayout = self.collectionViewLayout()
        return view
    }()
    
    var tasks: Results<ProductTable>!
    var productTableRepository = ProductTableRepository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = productTableRepository.fetch()
        collectionView.reloadData()
    }
    
    override func configureView() {
        // 서치바 네비게이션바에 내장
        self.navigationItem.searchController = searchController
        // 네비게이션바 타이틀
        title = Constants.TextContent.likeViewNavigationTitle
        // addSubView
        view.addSubview(collectionView)
        // realm DB 데이터 세팅
        tasks = productTableRepository.fetch()
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.verticalEdges.horizontalEdges.equalToSuperview()
        }
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        print(#function)
        
        showCancelLikeAlert {
            let product = self.tasks[sender.tag]
            self.productTableRepository.deleteItem(product)
            self.tasks = self.productTableRepository.fetch()
            self.collectionView.reloadData()
        }
        self.view.makeToast("해당 상품이 삭제되었습니다.")
    }
}


// MARK: - Extension - UISearchController, UISearchBar

extension LikeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print(searchText)
        
        let data = productTableRepository.fetch().where {
            $0.title.contains(searchText)
        }

        if !data.isEmpty {
            tasks = data
            collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

extension LikeViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        print(#function)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        print(#function)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tasks = productTableRepository.fetch()
        collectionView.reloadData()
    }
    
}

// MARK: - Extension UICollectionView

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        cell.configureCell(tasks[indexPath.row])
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
