//
//  ViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet var trendTableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    var movieResult: MovieResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTableView()
        configureTableView()
        initIndicatorView()
        
        callRequest()
    }
    
    func callRequest() {
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
        guard let movieListCount = movieResult?.movie.count else { return 0 }
        return movieListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = trendTableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if let movie = movieResult?.movie {
            cell.configureCell(movie[indexPath.row])
        }
        cell.designTableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController {
            navigationController?.show(vc, sender: nil)
            if let movie = movieResult?.movie {
                vc.movie = movie[indexPath.row]
            }
        }
    }
}

extension TrendViewController {
    func delegateTableView() {
        trendTableView.delegate = self
        trendTableView.dataSource = self
    }
    
    func configureTableView() {
        trendTableView.rowHeight = UITableView.automaticDimension
    }
    
    func initIndicatorView() {
        indicatorView.isHidden = true
    }
}


