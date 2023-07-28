//
//  MovieTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/28.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movie = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = MovieTableViewCellHeight.height.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        let row = movie.movie[indexPath.row]
        cell.configureCell(row: row)
        cell.designCell()
        
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        print(123)
        movie.movie[sender.tag].like.toggle()
        print(movie.movie[sender.tag].like)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }

}
