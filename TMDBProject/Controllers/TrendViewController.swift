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
    
    var movieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTableView()
        configureTableView()
        initIndicatorView()
        
        callRequest()
    }
    
    func callRequest() {
        TMDBAPIManager.shared.callRequest(type: EndPoint.trend, movieId: nil) { json in
            print("===")
            
            self.indicatorView.startAnimating()
            self.indicatorView.isHidden = false
            let results = json["results"].arrayValue
            
            for item in results {
                let date = item["release_date"].stringValue
                let mediaType = item["media_type"].stringValue
                let rate = item["vote_average"].doubleValue
                let title = item["title"].stringValue
                let description = item["overview"].stringValue
                let imageURL = item["backdrop_path"].stringValue
                
                let movie = Movie(
                    date: date,
                    mediaType: mediaType,
                    rate: rate,
                    title: title,
                    description: description,
                    imageURL: imageURL
                )
                
                self.movieList.append(movie)
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
            }
            self.trendTableView.reloadData()
        }
    }
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = trendTableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(movieList[indexPath.row])
        return cell
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


