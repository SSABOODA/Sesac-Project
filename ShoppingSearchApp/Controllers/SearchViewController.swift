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
        return view
    }()
    
    private lazy var searchBar = {
        let view = UISearchBar()
        view.placeholder = Constants.TextContent.searchBarPlaceHolder
        view.setValue("취소", forKey: "cancelButtonText")
        view.showsCancelButton = true
        view.delegate = self
        view.searchBarStyle = .minimal
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
    
    var shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    var itemList = [Item]()
    var searchText: String = ""
    
    var total: Int = 0
    var display: Int = 30
    var start: Int = 1
    var isEnd: Bool = false
    var currentSort: String = "sim"
    
    var accuracyFilterButtonIsSelected: Bool = false
    var dateFilterButtonIsSelected: Bool = false
    var highPriceFilterButtonIsSelected: Bool = false
    var lowPriceFilterButtonIsSelected: Bool = false
    
    let productTableRepository = ProductTableRepository.shared
    
    var tasks: Results<ProductTable>!
    
    func isSelectedFilterButton(_ isSelected: Bool, _ filterButton: UIButton) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableRepository.findFileURL()
        tasks = productTableRepository.fetch()
        
    }
    
    override func configureView() {
        super.configureView()
        
        configureNavigationBar()
        
        view.addSubview(searchBar)
        view.addSubview(stackView)
        view.addSubview(collectionView)
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
    }
    
    private func configureNavigationBar() {
        title = Constants.TextContent.searchViewNavigationTitle
    }
    
    @objc func filterButtonClicked(_ sender: UIButton) {
        print(#function)
        var result: Bool = false
        if sender == accuracyFilterButton {
            fetchAPI(query: searchText, sort: "sim", start: 1)
            accuracyFilterButtonIsSelected = accuracyFilterButtonIsSelected ? false : true
            result = accuracyFilterButtonIsSelected
            
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == dateFilterButton {
            fetchAPI(query: searchText, sort: "date", start: 1)
            currentSort = "date"
            dateFilterButtonIsSelected = dateFilterButtonIsSelected ? false : true
            result = dateFilterButtonIsSelected
            
            accuracyFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == highPriceFilterButton {
            fetchAPI(query: searchText, sort: "dsc", start: 1)
            currentSort = "dsc"
            highPriceFilterButtonIsSelected = highPriceFilterButtonIsSelected ? false : true
            result = highPriceFilterButtonIsSelected
            
            dateFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == lowPriceFilterButton {
            fetchAPI(query: searchText, sort: "asc", start: 1)
            currentSort = "asc"
            lowPriceFilterButtonIsSelected = lowPriceFilterButtonIsSelected ? false : true
            result = lowPriceFilterButtonIsSelected
            
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
        }
//        print("result: \(result)")
        isSelectedFilterButton(result, sender)
    }
    
    fileprivate func fetchAPI(query: String, sort: String, start: Int) {
        APIManager.shared.callRequest(query: query, apiType: .shopping, sort: sort, start: start) { result in
            switch result {
            case .success(let shoppingData):
//                print(shoppingData)
                self.shopping = shoppingData
                self.total = shoppingData.total
                self.itemList += shoppingData.items
                DispatchQueue.main.async {
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
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        var product = itemList[sender.tag]
        
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
        } else {
            // 데이터 삭제
            print("DELETE")
            let task = productData.first!
            productTableRepository.deleteItem(task)
        }
        itemList[sender.tag].isLike.toggle()
        
        self.view.makeToast("해당 상품을 찜하셨습니다.")
        
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let query = searchBar.text else { return }
        self.searchText = query
        fetchAPI(query: query, sort: "sim", start: 1)
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
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        var item = itemList[indexPath.row]
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        // 셀에 넣기 전에 realm에 있는 상품에 productId가 있으면 구조체 '좋아요' 정보 업뎃하고 셀 최신화하기
        let data = productTableRepository.fetch().where {
            $0.productId == item.productId
        }
        
        if !data.isEmpty {
            item.isLike = true
        }
        
        cell.configureCell(item)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(#function)
//    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if shopping.items.count - 1 == indexPath.row && start < total {
                start += display
                fetchAPI(query: searchText, sort: currentSort, start: start)
            }
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

