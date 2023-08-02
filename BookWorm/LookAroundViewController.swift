//
//  LookAroundViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController {
    
    static let identifier = "LookAroundViewController"
    
    var list = Array(repeating: "123", count: 100)
    
    @IBOutlet var popularityTableView: UITableView!
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet var recentCollectionView: UICollectionView!
    
    let movie = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        title = "둘러 보기"
        
        
        
        recentCollectionView.register(
            UINib(nibName: recentCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: recentCollectionViewCell.identifier
        )
        
    }
    
    func setupTableView() {
        popularityTableView.dataSource = self
        popularityTableView.delegate = self
    }
    
    func setupCollectionView() {
        recentCollectionView.dataSource = self
        recentCollectionView.delegate = self
        configureRecentCollectionViewLayout()
    }
    
    
    func configureRecentCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 85, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        recentCollectionView.collectionViewLayout = layout
        recentCollectionView.isPagingEnabled = true
    }
    

}

extension LookAroundViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = popularityTableView.dequeueReusableCell(withIdentifier: "LookAroundTableViewCell", for: indexPath) as? LookAroundTableViewCell else {
//            return UITableViewCell()
//        }
//
//        return cell
        
        
        let cell = popularityTableView.dequeueReusableCell(withIdentifier: "LookAroundTableViewCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(section)
        return "요즘 인기 작품"
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 10, y: 0, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 18)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    
}

extension LookAroundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = recentCollectionView.dequeueReusableCell(withReuseIdentifier: "LookAroundCollectionViewCell", for: indexPath) as? LookAroundCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        return cell
        
        
        guard let cell = recentCollectionView.dequeueReusableCell(withReuseIdentifier: recentCollectionViewCell.identifier, for: indexPath) as? recentCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(movie.movie[indexPath.row])
        
        return cell
        
    }
    
    
    
}
