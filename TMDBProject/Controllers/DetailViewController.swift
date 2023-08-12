//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/12.
//

import UIKit

class DetailViewController: UIViewController {
    
    // tableView header
    
    @IBOutlet var detailTableView: UITableView!
    
    @IBOutlet var overviewBackView: UIView!
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    var movie: Movie?
    var movieCastInfoList = [MovieCastInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTableView()
        configureTableView()
        
        configureNavigationBar()
        configureHeaderView()
        designHeaderView()
        
        callRequest()
    }
    
    
    func callRequest() {
        guard let movie else { return }
        TMDBAPIManager.shared.callRequest(type: EndPoint.credit, movieId: movie.id) { json in
            
            print("=====")
            print(json)
            
            let castData = json["cast"].arrayValue
            
            for item in castData {
                let castId = item["cast_id"].intValue
                let name = item["name"].stringValue
                let character = item["character"].stringValue
                let profileImageURL = item["profile_path"].stringValue
                
                let movieCastInfo = MovieCastInfo(
                    castId: castId,
                    name: name,
                    character: character,
                    profileImageURL: URL.baseImageURL + profileImageURL
                )
                self.movieCastInfoList.append(movieCastInfo)
            }
            self.detailTableView.reloadData()
        }
    }
    
    func configureNavigationBar() {
        title = "출연/제작"
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func configureHeaderView() {
        headerImageView.contentMode = .scaleAspectFill
        overviewLabel.numberOfLines = 0
        
        overviewBackView.layer.addBorder([.top, .bottom], color: UIColor.systemGray5, width: 1)
    }
    
    func designHeaderView() {
        guard let movie else { return }
        if let imageURL = URL(string: movie.imageURL) {
            headerImageView.kf.setImage(with: imageURL)
        }
        overviewLabel.text = movie.description
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCastInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(movieCastInfoList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
}


extension DetailViewController {
    func delegateTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    func configureTableView() {
        detailTableView.rowHeight = 130
    }
}
