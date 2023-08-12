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
        self.indicatorView.startAnimating()
        self.indicatorView.isHidden = false
        
        TMDBAPIManager.shared.callRequest(type: EndPoint.trend, movieId: nil) { json in
            sleep(1)
            let results = json["results"].arrayValue
            
            for item in results {
                let id = item["id"].intValue
                let date = item["release_date"].stringValue
                let mediaType = item["media_type"].stringValue
                let rate = item["vote_average"].doubleValue
                let title = item["title"].stringValue
                let description = item["overview"].stringValue
                let imageURL = item["backdrop_path"].stringValue
                
                let movie = Movie(
                    id: id,
                    date: date,
                    mediaType: mediaType,
                    rate: rate,
                    title: title,
                    description: description,
                    imageURL: URL.baseImageURL + imageURL
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
        cell.selectionStyle = .none
        cell.configureCell(movieList[indexPath.row])
        cell.designTableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController {
            navigationController?.show(vc, sender: nil)
            vc.movie = movieList[indexPath.row]
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


