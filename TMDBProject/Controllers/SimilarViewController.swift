//
//  SimilarViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/19.
//

import UIKit

class SimilarViewController: UIViewController {

    
    @IBOutlet var movieCollectionView: UICollectionView!
    
    var video: YoutubeVideo = YoutubeVideo(id: 0, video: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewDelegate()
        registerUINib()
        collectionViewLayout()
        
        callRequestVideo()
    }
    
    
    
    @IBAction func segmentButtonClicked(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    
    func callRequestVideo() {
        let movieId = 872585
        TMDBAPIManager.shared.callRequest(of: YoutubeVideo.self, type: .video, movieId: movieId, seriesId: nil, seasonId: nil) { data in
            print(123)
            print(data)
            
            self.video = data
            self.movieCollectionView.reloadData()
        }
    }
    
    
    
    
}

extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return video.video.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.identifier, for: indexPath) as? SimilarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        cell.moviePosterImageView.backgroundColor = .purple
        
        cell.configureCell(video.video[indexPath.row])
        
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


