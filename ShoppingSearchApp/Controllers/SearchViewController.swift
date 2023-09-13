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
    
    private lazy var stackView = {
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
    
    private lazy var filterButtonList = [
        accuracyFilterButton,
        dateFilterButton,
        highPriceFilterButton,
        lowPriceFilterButton
    ]
    
    var shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    var itemList = [Item]()
    var searchText: String = ""
    
    var total: Int = 0
    var display: Int = Constants.APIParameter.display
    var start: Int = Constants.APIParameter.start
    
    var currentSort: String = Constants.FilterSortName.accuracy
    var currentQuery: String = ""
    
    var accuracyFilterButtonIsSelected: Bool = false
    var dateFilterButtonIsSelected: Bool = false
    var highPriceFilterButtonIsSelected: Bool = false
    var lowPriceFilterButtonIsSelected: Bool = false
    
    let productTableRepository = ProductTableRepository.shared
    
    var tasks: Results<ProductTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = productTableRepository.findFileURL()
        tasks = productTableRepository.fetch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProductLikeData()
    }
    
    override func configureView() {
        super.configureView()
        
        configureNavigationBar()
        
        // keyboard dismiss
        keyboardDismiss()
        
        view.addSubview(searchBar)
        view.addSubview(stackView)
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)
        view.addSubview(searchEmptyView)
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
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view")
        searchBar.resignFirstResponder()
    }
    
    @objc func filterButtonClicked(_ sender: UIButton) {
        print(#function)
        
        if searchText.isEmpty {
            self.showNoQueryAlert()
            return
        }
        
        if sender == accuracyFilterButton {
        
            print("accuracyFilterButtonIsSelected: \(accuracyFilterButtonIsSelected)")
            
            if accuracyFilterButtonIsSelected == false {
                itemList.removeAll()
                fetchAPI(
                    query: searchText,
                    sort: Constants.FilterSortName.accuracy,
                    start: 1
                )
                accuracyFilterButtonIsSelected = accuracyFilterButtonIsSelected ? false : true
            }
            
            isSelectedFilterButton(accuracyFilterButtonIsSelected, sender)
            changeValueIsSelectedRemainFilterButton(filterButtonType: .accuracy)

        } else if sender == dateFilterButton {
            print("dateFilterButtonIsSelected: \(dateFilterButtonIsSelected)")
            
            if dateFilterButtonIsSelected == false {
                itemList.removeAll()
                let sort = Constants.FilterSortName.date
                fetchAPI(query: searchText, sort: sort, start: 1)
                currentSort = sort
                dateFilterButtonIsSelected = dateFilterButtonIsSelected ? false : true
            }
            isSelectedFilterButton(dateFilterButtonIsSelected, sender)
            changeValueIsSelectedRemainFilterButton(filterButtonType: .date)
            
        } else if sender == highPriceFilterButton {
            print("highPriceFilterButtonIsSelected: \(highPriceFilterButtonIsSelected)")
            if highPriceFilterButtonIsSelected == false {
                itemList.removeAll()
                let sort = Constants.FilterSortName.high
                fetchAPI(query: searchText, sort: sort, start: 1)
                currentSort = sort
                highPriceFilterButtonIsSelected = highPriceFilterButtonIsSelected ? false : true
            }
            
            isSelectedFilterButton(highPriceFilterButtonIsSelected, sender)
            changeValueIsSelectedRemainFilterButton(filterButtonType: .high)
        } else if sender == lowPriceFilterButton {
            print("lowPriceFilterButtonIsSelected: \(lowPriceFilterButtonIsSelected)")
            
            if lowPriceFilterButtonIsSelected == false {
                itemList.removeAll()
                let sort = Constants.FilterSortName.low
                fetchAPI(query: searchText, sort: sort, start: 1)
                currentSort = sort
                lowPriceFilterButtonIsSelected = lowPriceFilterButtonIsSelected ? false : true
            }
            isSelectedFilterButton(lowPriceFilterButtonIsSelected, sender)
            changeValueIsSelectedRemainFilterButton(filterButtonType: .low)
        }

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
            guard let task = productData.first else { return }
            productTableRepository.deleteItem(task)
            self.view.makeToast(Constants.LikeToastMessage.whenUserTapCancelLikeButton)
        }
        itemList[sender.tag].isLike.toggle()
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
    
    private func changeValueIsSelectedRemainFilterButton(filterButtonType: FilterButtonType) {
        switch filterButtonType {
        case .accuracy:
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
        case .date:
            accuracyFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
        case .high:
            dateFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
        case .low:
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
        }
    }
    
    private func updateProductLikeData() {
        let productList = productTableRepository.fetch()
        for (index, item) in itemList.enumerated() {
            itemList[index].isLike = false
            for product in productList {
                if item.productId == product.productId {
                    itemList[index].isLike = true
                }
            }
        }
        collectionView.reloadData()
    }
    
    // @deprecated
    private func keyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        collectionView.addGestureRecognizer(tap)
    }
 
    private func configureNavigationBar() {
        title = Constants.TextContent.searchViewNavigationTitle
    }
    
    private func fetchAPI(query: String, sort: String, start: Int) {
        
        if query.isEmpty {
            showNoQueryAlert()
            return
        }
        
        self.showIndicatorView(activityIndicatorView: self.activityIndicatorView, status: true)
        
        APIManager.shared.callRequest(query: query, apiType: .shopping, sort: sort, start: start) { result in
            switch result {
            case .success(let shoppingData):
                self.shopping = shoppingData
                self.total = shoppingData.total ?? 0
                self.itemList += shoppingData.items ?? []
                
                
                DispatchQueue.main.async {
                    // 검색 결과 없을 때 얼럿
                    if self.itemList.isEmpty {
                        self.noResultQueryAlert()
                    }
                    
                    self.collectionView.reloadData()
                    self.showIndicatorView(activityIndicatorView: self.activityIndicatorView, status: false)
                    if start == Constants.APIParameter.start {
                        self.collectionView.setContentOffset(.zero, animated: true)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showIndicatorView(activityIndicatorView: self.activityIndicatorView, status: false)
                    self.searchEmptyView.isHidden = true
                    switch error {
                    case .networkingError:
                        self.showNetworkingErrorAlert(title: Constants.NetworkErrorAlertText.networkingError) {
                        }
                    case .parseError:
                        self.showNetworkingErrorAlert(title: Constants.NetworkErrorAlertText.parseError) {
                        }
                    case .dataError:
                        print("")
                    }
                }
            }
        }
    }
    
    private func isSelectedFilterButton(_ isSelected: Bool, _ filterButton: UIButton) {
        filterButtonList.forEach { item in
            item.backgroundColor = .black
            item.setTitleColor(UIColor.white, for: .normal)
        }
        
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
        fetchAPI(query: query, sort: sort, start: Constants.APIParameter.start)
        currentSort = sort
        currentQuery = query
        
        accuracyFilterButtonIsSelected = true
        isSelectedFilterButton(accuracyFilterButtonIsSelected, accuracyFilterButton)
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        // 검색창 초기화
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        // 버튼 초기화
        filterButtonList.forEach { filterButton in
            isSelectedFilterButton(false, filterButton)
        }
        
        // api query 초기화
        self.searchText = ""
        
        // 데이터 초기화
        itemList.removeAll()
        collectionView.reloadData()
        
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
        
        // 셀 메서드에 넣기 전에 realm에 있는 상품에 productId가 있으면 구조체 'like' 정보 업데이트하고 셀 최신화하기
        comparingDataAfterUpdateLike(indexPath: indexPath)
        
        cell.configureCell(itemList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webView = WebViewController()
        
        webView.product = itemList[indexPath.row]
        webView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(webView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if itemList.count - 1 == indexPath.row && start < total {
                start += display
                let newStart = start + display
                fetchAPI(query: searchText, sort: currentSort, start: newStart)
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

