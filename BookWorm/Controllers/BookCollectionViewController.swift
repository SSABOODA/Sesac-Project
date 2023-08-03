//
//  BookCollectionViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit


class BookCollectionViewController: UICollectionViewController {
    
    static let identifier = "BookCollectionViewController"
    
    var movie = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerBookCollectionViewCell()
        setCollectionViewLayout()
        setBackgroundColor()
//        designNavigationBackButton()
    }
    
    // MARK: - IBAction

    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as? SearchViewController else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen // modal 방식
        present(nav, animated: true) // modal
    }
    
    
    
    @IBAction func lookAroundBarButtonItemClicked(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: LookAroundViewController.identifier) as? LookAroundViewController else { return }
        
        let tabBarVC = UITabBarController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        
        nav.title = "Tab1"
        vc2.title = "Tab2"
        vc3.title = "Tab3"
        
        tabBarVC.setViewControllers([nav, vc2, vc3], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        
        guard let items = tabBarVC.tabBar.items else { return }
        
        items.forEach { item in
            item.image = UIImage(systemName: "star.fill")
        }
        
        present(tabBarVC, animated: true)
    }
    
    func registerBookCollectionViewCell() {
        collectionView.register(
            UINib(nibName: BookCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: BookCollectionViewCell.identifier
        )
    }
    
    // MARK: - 구현 함수
    
    func designNavigationBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }

    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.minimumLineSpacing = spacing // 상하
        layout.minimumInteritemSpacing = spacing // 좌우
        collectionView.collectionViewLayout = layout
    }
        
    
    // MARK: - CollectionView Method

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(row: movie.movie[indexPath.row])
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifer) as? DetailViewController else {
            return
        }
        vc.movie = movie.movie[indexPath.row]
        vc.type = .main
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        print(#function)
        movie.movie[sender.tag].like.toggle()
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
}
