//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"

    @IBOutlet var collectionView: UICollectionView!
    
    var movie = MovieInfo()
    var filteredArr: [Movie] = []
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSerchView()
        navBarButtonItem()
        setupCollectionView()
        setupSearchController()
        
        registerBookCollectionViewCell()
        setCollectionViewLayout()
    }
    
    func registerBookCollectionViewCell() {
        collectionView.register(
            UINib(nibName: BookCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: BookCollectionViewCell.identifier
        )
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.minimumLineSpacing = spacing // 상하
        layout.minimumInteritemSpacing = spacing // 좌우
        collectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "영화 제목을 입력해주세요."
//        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "영화 검색 🔍"
    }
    
    func configureSerchView() {
        title = "검색 화면"
    }
    
    func navBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredArr = self.movie.movie.filter { $0.title.contains(text) }
        self.collectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredArr.count : self.movie.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        if self.isFiltering {
            cell.configureCell(row: filteredArr[indexPath.row])
        } else {
            cell.configureCell(row: movie.movie[indexPath.row])
        }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        print(#function)
        movie.movie[sender.tag].like.toggle()
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
}
