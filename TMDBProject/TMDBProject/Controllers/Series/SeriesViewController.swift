//
//  SeriesViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/16.
//

import UIKit

final class SeriesViewController: UIViewController {

    @IBOutlet var seriesCollectionView: UICollectionView!
    
    private var series: Series?
    private var seasonList: [SeasonInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        registerUINib()
        collectionViewDelegate()
        collectionViewLayout()
        fetchSeriesData()
    }
    
    private func setNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        rightBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // 66732 기묘한 이야기
    // 110534 DP
    // 2288 프리즌 브레이크
    // 60735 플래시
    // 1396 브레이킹 배드

    private func fetchSeriesData() {
        TMDBAPIManager.shared.callRequest(
            of: Series.self,
            type: EndPoint.series,
            movieId: nil,
            seriesId: 66732,
            seasonId: nil
        ) { [weak self] response in
            self?.series = response
            guard let series = self?.series else { return }
            
            self?.navigationItem.title = series.name
            
            for item in series.seasons {
                self?.fetchSeries(seriesId: series.id, seasonId: item.seasonNumber) { data in
                    self?.seasonList.append(data)
                    self?.seriesCollectionView.reloadData()
                }
            }
        }
    }
    
    private func fetchSeries(seriesId: Int, seasonId: Int, completionHandler: @escaping (SeasonInfo) -> Void ) {
        TMDBAPIManager.shared.callRequest(
            of: SeasonInfo.self,
            type: EndPoint.season,
            movieId: nil,
            seriesId: seriesId,
            seasonId: seasonId
        ) { response in
            completionHandler(response)
        }
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
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as? SeriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        if !seasonList.isEmpty {
            let episode = seasonList[indexPath.section].episodes[indexPath.row]
            cell.configureCell(episode)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeriesCollectionReusableView.identifier, for: indexPath) as? SeriesCollectionReusableView else {
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

extension SeriesViewController: CollectionViewAttributeProtocol {
    func collectionViewDelegate() {
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
    }
    
    func registerUINib() {
        seriesCollectionView.register(
            UINib(nibName: SeriesCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier
        )
        seriesCollectionView.register(
            UINib(nibName: SeriesCollectionReusableView.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SeriesCollectionReusableView.identifier
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
