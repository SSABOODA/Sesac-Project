//
//  SimilarViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/19.
//

import UIKit
import WebKit

class SimilarViewController: UIViewController {

    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var videoSegmentControl: UISegmentedControl!
    
    var video: YoutubeVideo = YoutubeVideo(id: 0, video: [])
    var similarVideo: SimilarMovieData = SimilarMovieData(results: [])
    
    let movieId = 299534
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewDelegate()
        registerUINib()
        collectionViewLayout()
        callRequestVideo()
    }

    @IBAction func segmentButtonClicked(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        movieCollectionView.reloadData()
    }
    
    
    func callRequestVideo() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.callRequest(of: YoutubeVideo.self, type: .video, movieId: movieId, seriesId: nil, seasonId: nil) { data in
            self.video = data
            print(data)
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.callRequest(of: SimilarMovieData.self, type: .similar, movieId: movieId, seriesId: nil, seasonId: nil) { data in
            self.similarVideo = data
            print(data)
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("END")
            self.movieCollectionView.reloadData()
        }
    }
}

extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoSegmentControl.selectedSegmentIndex == 0 ? video.video.count : similarVideo.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.identifier, for: indexPath) as? SimilarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if videoSegmentControl.selectedSegmentIndex == 0 {
            cell.configureVideo(video.video[indexPath.row])
        } else {
            cell.configureSimilarVideo(similarVideo.results[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = video.video[indexPath.item].key
        let vc = WebViewViewController()
        vc.youtubeKey = key
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
}


extension SimilarViewController: CollectionViewAttributeProtocol {
    func collectionViewDelegate() {
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    func registerUINib() {
        movieCollectionView.register(
            UINib(nibName: SimilarCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: SimilarCollectionViewCell.identifier
        )
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width/2, height: 200)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        movieCollectionView.collectionViewLayout = layout
    }
}


