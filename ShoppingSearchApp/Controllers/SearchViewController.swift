//
//  ViewController.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController {
    
    lazy var collectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout()
        )
        view.delegate = self
        view.dataSource = self
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
    var searchText: String = ""
    
    var accuracyFilterButtonIsSelected: Bool = false
    var dateFilterButtonIsSelected: Bool = false
    var highPriceFilterButtonIsSelected: Bool = false
    var lowPriceFilterButtonIsSelected: Bool = false
    
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
            fetchAPI(query: searchText, sort: "sim")
            accuracyFilterButtonIsSelected = accuracyFilterButtonIsSelected ? false : true
            result = accuracyFilterButtonIsSelected
            
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == dateFilterButton {
            fetchAPI(query: searchText, sort: "date")
            dateFilterButtonIsSelected = dateFilterButtonIsSelected ? false : true
            result = dateFilterButtonIsSelected
            
            accuracyFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == highPriceFilterButton {
            fetchAPI(query: searchText, sort: "dsc")
            highPriceFilterButtonIsSelected = highPriceFilterButtonIsSelected ? false : true
            result = highPriceFilterButtonIsSelected
            
            dateFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
            lowPriceFilterButtonIsSelected = false
            
        } else if sender == lowPriceFilterButton {
            fetchAPI(query: searchText, sort: "asc")
            lowPriceFilterButtonIsSelected = lowPriceFilterButtonIsSelected ? false : true
            result = lowPriceFilterButtonIsSelected
            
            dateFilterButtonIsSelected = false
            highPriceFilterButtonIsSelected = false
            accuracyFilterButtonIsSelected = false
        }
//        print("result: \(result)")
        isSelectedFilterButton(result, sender)
    }
    
   
    func fetchAPI(query: String, sort: String) {
        APIManager.shared.callRequest(query: query, apiType: .shopping, sort: sort) { result in
            switch result {
            case .success(let shoppingData):
//                print(shoppingData)
                self.shopping = shoppingData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.setContentOffset(.zero, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let query = searchBar.text else { return }
        self.searchText = query
        fetchAPI(query: query, sort: "sim")
        accuracyFilterButtonIsSelected = true
        isSelectedFilterButton(accuracyFilterButtonIsSelected, accuracyFilterButton)
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(shopping.items.count)
        return shopping.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .systemBackground
        cell.configureCell(shopping.items[indexPath.row])
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
//            height: 270
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

