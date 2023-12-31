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
        view.searchBar.placeholder = Constants.TextContent.searchBarPlaceHolder
        view.hidesNavigationBarDuringPresentation = false
        view.navigationItem.hidesSearchBarWhenScrolling = false
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        view.searchBar.tintColor = .white
        view.searchBar.searchBarStyle = .minimal
        view.searchResultsUpdater = self
        view.searchBar.delegate = self
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
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    private let likeEmptyView = LikeEmptyView()
    
    var tasks: Results<ProductTable>!
    var productTableRepository = ProductTableRepository.shared
    var productId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
        // 네비게이션 BackButton 설정
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = ""
        navigationItem.backBarButtonItem = backBarBtnItem
        
        // addSubView
        view.addSubview(collectionView)
        view.addSubview(likeEmptyView)
        
        // realm DB 데이터 세팅
        tasks = productTableRepository.fetch()
        
        // keyboard dismiss
//        keyboardDismiss()
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        likeEmptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view")
        searchController.searchBar.resignFirstResponder()
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        print(#function)
        showCancelLikeAlert {
            let product = self.tasks[sender.tag]
            
            // Realm DB에 데이터 삭제하고 reloadData()
            self.productTableRepository.deleteItem(product)
            guard let searchText = self.searchController.searchBar.text else { return }
            
            if !searchText.isEmpty {
                self.tasks = self.productTableRepository.fetch().where({
                    $0.title.contains(searchText)
                })
            } else {
                self.tasks = self.productTableRepository.fetch()
            }
            
            self.collectionView.reloadData()
            self.view.makeToast(Constants.LikeToastMessage.whenUserTapCancelLikeButton)
        }
    }
    
    private func keyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
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
        likeEmptyView.isHidden = tasks.isEmpty ? false : true
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webView = WebViewController()
        let task = tasks[indexPath.row]
        
        var product = Item(
            title: task.title,
            link: "",
            image: "",
            lprice: task.price,
            hprice: "",
            mallName: task.mallName,
            productId: task.productId,
            productType: "",
            brand: ""
        )
        
        product.isLike = task.isLike
        webView.product = product
        
        webView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(webView, animated: true)
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
