//
//  SeriesViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/16.
//

import UIKit

class SeriesViewController: UIViewController {

    
    @IBOutlet var seriesCollectionView: UICollectionView!
    
    
    var series: Series?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDelegate()
        registerUINib()
        collectionViewLayout()
        
        fetchSeriesData()
    }
    
    func fetchSeriesData() {
        TMDBAPIManager.shared.callRequest(of: Series.self, type: EndPoint.series, movieId: nil) { response in
            print("closure")
//            print(response)
            
            self.series = response.value
            self.seriesCollectionView.reloadData()
        }
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
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width, height: 150)
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.minimumLineSpacing = spacing // 상하
        layout.minimumInteritemSpacing = spacing // 좌우
        layout.scrollDirection = .vertical
        
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        seriesCollectionView.collectionViewLayout = layout
    }

}


extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let count = series?.seasons.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let series else { return 0 }
        let seriesCount = series.seasons.map { $0.episodeCount }
        return seriesCount[section]
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
            
            if let series {
                
                view.configureReusableView(series.seasons[indexPath.section])
            }
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
}
