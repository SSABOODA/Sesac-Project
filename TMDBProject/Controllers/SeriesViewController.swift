//
//  SeriesViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/16.
//

import UIKit

class SeriesViewController: UIViewController {

    
    @IBOutlet var seriesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDelegate()
        registerUINib()
        collectionViewLayout()
    }
    
    func collectionViewDelegate() {
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
    }
    
    func registerUINib() {
        seriesCollectionView.register(
            UINib(nibName: "SeriesCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "SeriesCollectionViewCell"
        )
        seriesCollectionView.register(
            UINib(nibName: "SeriesCollectionReusableView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SeriesCollectionReusableView"
        )
    }
    
    func collectionViewLayout() {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 100, height: 100)
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 8
//        layout.scrollDirection = .vertical
//
//        seriesCollectionView.collectionViewLayout = layout
        
        
        // cell estimated size none으로 인터페이스 빌더에서 설정할 것!
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
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        seriesCollectionView.collectionViewLayout = layout
    }

}


extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCollectionViewCell", for: indexPath) as? SeriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SeriesCollectionReusableView", for: indexPath) as? SeriesCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.seasonLabel.text = "시즌 1"
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
}
