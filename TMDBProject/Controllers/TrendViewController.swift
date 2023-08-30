//
//  ViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import UIKit

// 416

class TrendViewController: UIViewController {

//    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private lazy var trendTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: "TrendCell")
        return tableView
    }()
    
    var movieResult: MovieResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        view.backgroundColor = .white
        
//        indicatorView.isHidden = true
        
        configureView()
        setConstraints()
        
    }
    
    private func configureView() {
        view.addSubview(trendTableView)
    }
    
    private func setConstraints() {
        trendTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func callRequest() {
//        self.indicatorView.startAnimating()
//        self.indicatorView.isHidden = false
        
        TMDBAPIManager.shared.callRequest(
            of: MovieResult.self,
            type: EndPoint.trend,
            movieId: nil,
            seriesId: nil,
            seasonId: nil
        ) { response in
            sleep(1)
            self.movieResult = response
//            self.indicatorView.stopAnimating()
//            self.indicatorView.isHidden = true
            self.trendTableView.reloadData()
        }
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieListCount = movieResult?.movie.count else { return 0 }
        return movieListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = trendTableView.dequeueReusableCell(withIdentifier: "TrendCell") as? TrendTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if let movie = movieResult?.movie {
            cell.configureCell(movie[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        guard let movie = movieResult?.movie else { return }
        
        vc.movie = movie[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
