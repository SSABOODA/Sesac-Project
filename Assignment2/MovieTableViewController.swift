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
    
    @IBAction func moreInformationButtonClicked(_ sender: UIBarButtonItem) {
        let like = UIAction(title: "즐겨찾기 ❤️", handler: { _ in self.showLikeMovieData() })
        let revert = UIAction(title: "전체 목록 🍿", handler: { _ in self.revertMovieData() })
        let buttonMenu = UIMenu(title: "추가 기능", children: [like, revert])
        sender.menu = buttonMenu
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        movie.movie[sender.tag].like.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .left)
    }
    
    func showLikeMovieData() {
        print(#function)
        movie.updateLikeMovieData()
        tableView.reloadData()
    }
    
    func revertMovieData() {
        print(#function)
        movie.revertMovieData()
        tableView.reloadData()
    }

}
