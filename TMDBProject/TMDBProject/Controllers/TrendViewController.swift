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
    
    var movieResult: MovieResult = MovieResult(totalResults: 0, totalPages: 0, page: 0, movie: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        view.backgroundColor = .white
        navigationItem.title = "영화 목록"
        configureView()
        setConstraints()
        
    }
    
    private func configureView() {
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
    
    private func callRequest() {
        self.indicatorView.startAnimating()
        self.indicatorView.isHidden = false
        
        TMDBAPIManager.shared.callRequest(
            of: MovieResult.self,
            type: EndPoint.trend,
            movieId: nil,
            seriesId: nil,
            seasonId: nil
        ) { response in
            sleep(1)
            self.movieResult = response
            
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.trendTableView.reloadData()
        }
    }
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResult.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieList = movieResult.movie
        
        let cellIdentifier = movieList[indexPath.row].mediaType.cellIdentifier
        let mediaType = movieList[indexPath.row].mediaType
        switch mediaType {
        case .movie:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrendMovieTableViewCell else { return UITableViewCell() }
            cell.configureCell(movieList[indexPath.row])
            return cell
        case.tv:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrendTVTableViewCell else { return UITableViewCell() }
            cell.configureCell(movieList[indexPath.row])
            return cell
        case .person:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrendPersonTableViewCell else { return UITableViewCell() }
            cell.configureCell(movieList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        let movie = movieResult.movie
        
        vc.movie = movie[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

