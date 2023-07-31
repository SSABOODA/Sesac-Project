//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    let movieArr = MovieInfo().movie.map { $0.title }
    var filteredArr: [String] = []
    
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
        setupTableView()
        setupSearchController()
        
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "영화 제목을 입력해주세요."
//        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search"
        
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
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredArr = self.movieArr.filter { $0.localizedCaseInsensitiveContains(text) }
        
        self.tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredArr.count : self.movieArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if self.isFiltering {
            cell.textLabel?.text = self.filteredArr[indexPath.row]
        } else {
            cell.textLabel?.text = self.movieArr[indexPath.row]
        }
        return cell
    }
}
