//
//  LookAroundViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController {
    
    static let identifier = "LookAroundViewController"
    
    @IBOutlet var popularityTableView: UITableView!
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet var recentCollectionView: UICollectionView!
    
    let movie = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        configurePopularityTableView()
        title = "둘러 보기"
        navBarButtonItem()
        
        
        popularityTableView.register(
            UINib(nibName: PopularityTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: PopularityTableViewCell.identifier
        )
        
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
    
    func configurePopularityTableView() {
        popularityTableView.rowHeight = 120
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
    
    func navBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    

}

extension LookAroundViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.movie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = popularityTableView.dequeueReusableCell(withIdentifier: PopularityTableViewCell.identifier, for: indexPath) as? PopularityTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(movie.movie[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifer) as? DetailViewController else { return }
        vc.movie = movie.movie[indexPath.row]
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
}

extension LookAroundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = recentCollectionView.dequeueReusableCell(withReuseIdentifier: recentCollectionViewCell.identifier, for: indexPath) as? recentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(movie.movie[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifer) as? DetailViewController else { return }
        vc.movie = movie.movie[indexPath.row]
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
