//
//  DetailViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailMainImageView: UIImageView!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailRateLabel: UILabel!
    @IBOutlet var detailDescriptionLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        designImageView()
    }
    
    
    func designImageView() {
        detailMainImageView.backgroundColor = .clear
        detailMainImageView.layer.cornerRadius = 10
        detailMainImageView.clipsToBounds = true
    }
    
    func configureDetailView() {
        guard let movie = movie else {
            return
        }
        detailMainImageView.image = UIImage(named: movie.title)
        detailTitleLabel.text = movie.title
        detailRateLabel.text = "평점: \(movie.rate)"
        detailDescriptionLabel.text = movie.overview
        
        title = movie.title
    }
}
