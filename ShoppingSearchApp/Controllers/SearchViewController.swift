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
        view.addTarget(self, action: #selector(accuracyFilterButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var dateFilterButton = {
        let view = FilterButton()
        view.setTitle(Constants.FilterButtonTitle.dateFilterButtonTitle, for: .normal)
        view.addTarget(self, action: #selector(dateFilterButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var lowPriceFilterButton = {
        let view = FilterButton()
        view.setTitle(Constants.FilterButtonTitle.lowPriceFilterButtonTitle, for: .normal)
        view.addTarget(self, action: #selector(lowPriceFilterButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var highPriceFilterButton = {
        let view = FilterButton()
        view.setTitle(Constants.FilterButtonTitle.highPriceFilterButtonTitle, for: .normal)
        view.addTarget(self,action: #selector(highPriceFilterButtonTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var stackView = {
        let view = UIStackView(arrangedSubviews: [
            accuracyFilterButton,
            dateFilterButton,
            lowPriceFilterButton,
            highPriceFilterButton,
        ])
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    var shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    
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
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalToSuperview().offset(Constants.ColletionViewLayoutDesign.spacing)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        title = Constants.TextContent.searchViewNavigationTitle
    }
    
    @objc func accuracyFilterButtonTapped() { print(#function) }
    @objc func dateFilterButtonTapped() { print(#function) }
    @objc func lowPriceFilterButtonTapped() { print(#function) }
    @objc func highPriceFilterButtonTapped() { print(#function) }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let query = searchBar.text else { return }
        
        APIManager.shared.callRequest(query: query, apiType: .shopping) { result in
            switch result {
            case .success(let shoppingData):
                print(shoppingData)
                self.shopping = shoppingData
            case .failure(let error):
                print(error)
            }
        }
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
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .systemBackground
        
        
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
            height: 250
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
