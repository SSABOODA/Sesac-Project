//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/12.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var headerImageView: UIImageView!
    
    
    
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        callRequest()
    }
    
    func configureNavigationBar() {
        title = "출연/제작"
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func callRequest() {
        guard let movie else { return }
        TMDBAPIManager.shared.callRequest(type: EndPoint.credit, movieId: movie.id) { json in
            
            print("=====")
            print(json)
            
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        
        return cell
    }
}

