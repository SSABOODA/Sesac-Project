//
//  BookCollectionViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit


class BookCollectionViewController: UICollectionViewController {
    
    var movie = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerBookCollectionViewCell()
        setCollectionViewLayout()
        setBackgroundColor()
    }
    
    // MARK: - IBAction

    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: ViewControllerIdentifier.searchView.rawValue) as? SearchViewController else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen // modal 방식
        present(nav, animated: true) // modal
    }
    
    func registerBookCollectionViewCell() {
        collectionView.register(
            UINib(nibName: CollectionViewCellIdentifier.bookCollectionViewCell.rawValue, bundle: nil),
            forCellWithReuseIdentifier: CollectionViewCellIdentifier.bookCollectionViewCell.rawValue
        )
    }
    
    // MARK: - 구현 함수

    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.bookCollectionViewCell.rawValue, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.designCell(movie.colorList.randomElement()!)
        cell.configureCell(row: movie.movie[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: ViewControllerIdentifier.detailView.rawValue) as? DetailViewController else {
            return
        }
        vc.movie = movie.movie[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
