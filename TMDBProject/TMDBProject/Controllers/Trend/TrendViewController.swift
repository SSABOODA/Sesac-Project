//
//  ViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {
    
    static let TrendMovieCellIdentifier = String(describing: type(of: TrendMovieTableViewCell.self))
    static let TrendTVCellIdentifier = String(describing: type(of: TrendTVTableViewCell.self))
    static let TrendPersonCellIdentifier = String(describing: type(of: TrendPersonTableViewCell.self))
    
    private lazy var trendTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(
            TrendMovieTableViewCell.self,
            forCellReuseIdentifier: TrendViewController.TrendMovieCellIdentifier
        )
        tableView.register(
            TrendTVTableViewCell.self,
            forCellReuseIdentifier: TrendViewController.TrendTVCellIdentifier
        )
        tableView.register(
            TrendPersonTableViewCell.self,
            forCellReuseIdentifier: TrendViewController.TrendPersonCellIdentifier
        )
        
        return tableView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        return activityView
    }()
    
    let searchController = {
        let s = UISearchController(searchResultsController: nil)
        return s
    }()
    
//    var movieSearch: MovieSearch = MovieSearch(page: 0, results: [], totalResults: 0, totalPages: 0)
    var movieResult: MovieResult = MovieResult(totalResults: 0, totalPages: 0, page: 0, movie: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest(query: "", endPointType: .trend)
        
        setHierarchy()
        setSearchBar()
        setAttributes()
        setConstraints()
        setNavigationBar()
    }
    
    private func setSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "영화를 검색해보세요"
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setAttributes() {
        view.backgroundColor = .black
    }
    
    private func setHierarchy() {
        view.addSubview(trendTableView)
        trendTableView.addSubview(indicatorView)
    }
    
    private func setConstraints() {
        trendTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "영화 목록"
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func callRequest(query: String?, endPointType: EndPoint) {
        
        self.indicatorView.startAnimating()
        self.indicatorView.isHidden = false
        
        TMDBAPIManager.shared.callRequest(
            of: MovieResult.self,
            type: endPointType,
            movieId: nil,
            seriesId: nil,
            seasonId: nil,
            query: query
        ) { response in
            sleep(1)
            self.movieResult = response
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.trendTableView.reloadData()
            
//            print("self.movieResult: \(self.movieResult)")
        }
    }
}


// MARK: - UISearchBarDelegate
extension TrendViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        self.movieResult = MovieResult(
            totalResults: 0,
            totalPages: 0,
            page: 0,
            movie: []
        )
        self.trendTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button click")
        self.callRequest(query: searchBar.text, endPointType: .search)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResult.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cellIdentifier = movieList[indexPath.row].mediaType.cellIdentifier
//        let mediaType = movieList[indexPath.row].mediaType
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendViewController.TrendMovieCellIdentifier, for: indexPath) as? TrendMovieTableViewCell else { return UITableViewCell() }

        if movieResult.movie[indexPath.row].posterPath != nil ||
            movieResult.movie[indexPath.row].imageURL != nil {
            cell.configureCell(movieResult.movie[indexPath.row])
        }
        
        
        return cell
        
//        switch mediaType {
//        case .movie:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrendMovieTableViewCell else { return UITableViewCell() }
//            cell.configureCell(movieList[indexPath.row])
//            return cell
//        case.tv:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrendTVTableViewCell else { return UITableViewCell() }
//            cell.configureCell(movieList[indexPath.row])
//            return cell
//        case .person:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrendPersonTableViewCell else { return UITableViewCell() }
//            cell.configureCell(movieList[indexPath.row])
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        let movie = movieResult.movie
        
        vc.movie = movie[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

