//
//  ViewController.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit
import SnapKit
import RealmSwift
import Toast

final class SearchViewController: BaseViewController {
    lazy var collectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout()
        )
        view.delegate = self
        view.dataSource = self
        view.prefetchDataSource = self
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        view.collectionViewLayout = collectionViewLayout()
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    private lazy var searchBar = {
        let view = UISearchBar()
        view.placeholder = Constants.TextContent.searchBarPlaceHolder
        view.setValue("취소", forKey: "cancelButtonText")
        view.showsCancelButton = true
        view.delegate = self
        view.searchBarStyle = .minimal
        view.tintColor = .white
        return view
    }()
    
    private lazy var accuracyFilterButton = {
        let view = FilterButton()
        view.setTitle(Constants.FilterButtonTitle.accuracyFilterButtonTitle, for: .normal)
        view.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var dateFilterButton = {
        let view = FilterButton()
        view.setTitle(Constants.FilterButtonTitle.dateFilterButtonTitle, for: .normal)
        view.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var highPriceFilterButton = {
        let view = FilterButton()
        view.setTitle(Constants.FilterButtonTitle.highPriceFilterButtonTitle, for: .normal)
        view.addTarget(self,action: #selector(filterButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var lowPriceFilterButton = {
        let view = FilterButton()
        view.setTitle(Constants.FilterButtonTitle.lowPriceFilterButtonTitle, for: .normal)
        view.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        return view
    }()
    
    lazy var stackView = {
        let view = UIStackView(arrangedSubviews: [
            accuracyFilterButton,
            dateFilterButton,
            highPriceFilterButton,
            lowPriceFilterButton,
        ])
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private let searchEmptyView = SearchEmptyView()
    
    private let activityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    var shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    var itemList = [Item]()
    var searchText: String = ""
    
    var total: Int = 0
    var display: Int = 30
    var start: Int = 1
    var isEnd: Bool = false
    var currentSort: String = Constants.FilterSortName.accuracy
    var currentQuery: String = ""
    
    var accuracyFilterButtonIsSelected: Bool = false
    var dateFilterButtonIsSelected: Bool = false
    var highPriceFilterButtonIsSelected: Bool = false
    var lowPriceFilterButtonIsSelected: Bool = false
    
    let productTableRepository = ProductTableRepository.shared
    
    var tasks: Results<ProductTable>!
    var productId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = productTableRepository.findFileURL()
        tasks = productTableRepository.fetch()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("productId: \(productId)")
        
        if !productId.isEmpty {
            for (index, item) in itemList.enumerated() {
                if item.productId == productId {
                    itemList[index].isLike = false
                    collectionView.reloadData()
                }
            }
        }
    }
    
    override func configureView() {
        super.configureView()
        
        configureNavigationBar()
        // keyboard dismiss
//        keyboardDismiss()
        
        view.addSubview(searchBar)
        view.addSubview(stackView)
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)
        view.addSubview(searchEmptyView)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view")
        searchBar.resignFirstResponder()
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(Constants.ColletionViewLayoutDesign.spacing)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        searchEmptyView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
    @objc func filterButtonClicked(_ sender: UIButton) {
        print(#function)
        itemList.removeAll()
        collectionView.reloadData()
        if searchText.isEmpty { self.showNoQueryAlert() }
        
        var result: Bool = false
        if sender == accuracyFilterButton {
            itemList.removeAll()
            let sort = Constants.FilterSortName.accuracy
            fetchAPI(query: searchText, sort: sort, start: 1)
            result = accuracyFilterButtonIsSelected ? false : true
            
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == dateFilterButton {
            itemList.removeAll()
            let sort = Constants.FilterSortName.date
            fetchAPI(query: searchText, sort: sort, start: 1)
            currentSort = sort
            result = dateFilterButtonIsSelected ? false : true
            
            accuracyFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == highPriceFilterButton {
            itemList.removeAll()
            let sort = Constants.FilterSortName.high
            fetchAPI(query: searchText, sort: sort, start: 1)
            currentSort = sort
            result = highPriceFilterButtonIsSelected ? false : true
            
            dateFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == lowPriceFilterButton {
            itemList.removeAll()
            let sort = Constants.FilterSortName.low
            fetchAPI(query: searchText, sort: sort, start: 1)
            currentSort = sort
            result = lowPriceFilterButtonIsSelected ? false : true
            
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
        }
        isSelectedFilterButton(result, sender)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        let product = itemList[sender.tag]
        
        let productData = productTableRepository.fetch().where {
            $0.productId == product.productId
        }
        
        var imageData: Data?
        
        if productData.isEmpty {
            // 데이터 저장
            print("SAVE")
            
            let url = URL(string: product.image)
            DispatchQueue.global().async {
                if let url = url, let data = try? Data(contentsOf: url) {
                    imageData = data
                    
                    DispatchQueue.main.async {
                        let task = ProductTable(
                            productId: product.productId,
                            title: product.title,
                            image: imageData,
                            mallName: product.mallName,
                            price: product.lprice
                        )
                        self.productTableRepository.createItem(task)
                        
                        self.productTableRepository.updateItem(
                            updateValue: [
                                "_id": task._id,
                                "isLike": task.isLike ? false : true
                            ]
                        )
                    }
                }
            }
            self.view.makeToast(Constants.LikeToastMessage.whenUserTapLikeButton)
        } else {
            // 데이터 삭제
            print("DELETE")
            let task = productData.first!
            productTableRepository.deleteItem(task)
            self.view.makeToast(Constants.LikeToastMessage.whenUserTapCancelLikeButton)
        }
        itemList[sender.tag].isLike.toggle()
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
    
    private func keyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    } // 삭제 예정
 
    private func configureNavigationBar() {
        title = Constants.TextContent.searchViewNavigationTitle
    }
    
    private func fetchAPI(query: String, sort: String, start: Int) {
        
        if query.isEmpty { return }
        
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.isHidden = false
        
        APIManager.shared.callRequest(query: query, apiType: .shopping, sort: sort, start: start) { result in
            switch result {
            case .success(let shoppingData):
                self.shopping = shoppingData
                self.total = shoppingData.total
                self.itemList += shoppingData.items
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.isHidden = true
                    self.collectionView.reloadData()
                    if start == 1 {
                        self.collectionView.setContentOffset(.zero, animated: true)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func isSelectedFilterButton(_ isSelected: Bool, _ filterButton: UIButton) {
        accuracyFilterButton.backgroundColor = .black
        accuracyFilterButton.setTitleColor(UIColor.white, for: .normal)
        dateFilterButton.backgroundColor = .black
        dateFilterButton.setTitleColor(UIColor.white, for: .normal)
        highPriceFilterButton.backgroundColor = .black
        highPriceFilterButton.setTitleColor(UIColor.white, for: .normal)
        lowPriceFilterButton.backgroundColor = .black
        lowPriceFilterButton.setTitleColor(UIColor.white, for: .normal)
        
        if isSelected {
            filterButton.backgroundColor = .white
            filterButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            filterButton.backgroundColor = .black
            filterButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text else { return }
        self.searchText = query
        itemList.removeAll()
        
        let sort = Constants.FilterSortName.accuracy
        fetchAPI(query: query, sort: sort, start: 1)
        currentSort = sort
        currentQuery = query
        
        accuracyFilterButtonIsSelected = true
        isSelectedFilterButton(accuracyFilterButtonIsSelected, accuracyFilterButton)
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchEmptyView.isHidden = itemList.isEmpty ? false : true
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        // 셀 메서드에 넣기 전에 realm에 있는 상품에 productId가 있으면 구조체 'like' 정보 업뎃하고 셀 최신화하기
        comparingDataAfterUpdateLike(indexPath: indexPath)
        
        cell.configureCell(itemList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webView = WebViewController()
        
        webView.passDataHandler = { data in
            print("completionHandler")
            self.productId = data
        }
        
        webView.product = itemList[indexPath.row]
        webView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(webView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if shopping.items.count - 1 == indexPath.row && start < total {
                start += display
                fetchAPI(query: searchText, sort: currentSort, start: start)
            }
        }
    }
    
    private func comparingDataAfterUpdateLike(indexPath: IndexPath) {
        let item = itemList[indexPath.row]
        let data = productTableRepository.fetch().where {
            $0.productId == item.productId
        }
        
        if !data.isEmpty {
            itemList[indexPath.row].isLike = true
        }
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

