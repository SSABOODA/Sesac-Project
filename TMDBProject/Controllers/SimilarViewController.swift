//
//  SimilarViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/19.
//

import UIKit

class SimilarViewController: UIViewController {

    
    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var videoSegmentControl: UISegmentedControl!
    
    
    var video: YoutubeVideo = YoutubeVideo(id: 0, video: [])
    var similarVideo: SimilarMovieData = SimilarMovieData(results: [])
    
    let movieId = 872585
    
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
            print(data)
            
            self.video = data
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.callRequest(of: SimilarMovieData.self, type: .similar, movieId: movieId, seriesId: nil, seasonId: nil) { data in
            self.similarVideo = data
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("END")
            
            print("Video======", self.video)
            print("Similar=====", self.similarVideo)
            
            self.movieCollectionView.reloadData()
        }
        
    }
    
    
    
    
}

extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if videoSegmentControl.selectedSegmentIndex == 0 {
            return video.video.count
        } else {
            return similarVideo.results.count
        }
        
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
        
        
        print("cell", videoSegmentControl.selectedSegmentIndex)
        
        return cell
    }
}


extension SimilarViewController: CollectionViewAttributeProtocol {
    func collectionViewDelegate() {
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    func registerUINib() {
        movieCollectionView.register(UINib(nibName: SimilarCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SimilarCollectionViewCell.identifier)
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width/3, height: 170)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        movieCollectionView.collectionViewLayout = layout
    }
    
    
}


