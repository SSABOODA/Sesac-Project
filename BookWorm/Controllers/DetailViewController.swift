//
//  DetailViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifer = "DetailViewController"
    
    var type: TransitionType = .main

    @IBOutlet var detailMainImageView: UIImageView!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailRuntimeLabel: UILabel!
    @IBOutlet var detailRateLabel: UILabel!
    @IBOutlet var detailDescriptionLabel: UILabel!
    @IBOutlet var detailView: UIView!
    
    var movie: Movie?
    var beforeClassName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        designImageView()
        leftNavigationBarButtonItem()
    }

    func leftNavigationBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func closeButtonClicked() {
        switch type {
        case .main: navigationController?.popViewController(animated: true)
        case .around: dismiss(animated: true)
        case .search: dismiss(animated: true)
        }
        
    }
    
    func designImageView() {
        detailMainImageView.backgroundColor = .clear
        detailMainImageView.layer.cornerRadius = 10
        detailMainImageView.clipsToBounds = true
    }
    
    func configureDetailView() {
        guard let movie = movie else { return }
        detailMainImageView.image = UIImage(named: movie.title)
        detailTitleLabel.text = movie.title
        detailRuntimeLabel.text = movie.runtimeText
        detailRateLabel.text = movie.rateText
        detailDescriptionLabel.text = movie.overview
        
        detailDescriptionLabel.numberOfLines = 0
        view.backgroundColor = .systemGray4
        detailView.layer.cornerRadius = 10
        detailView.clipsToBounds = true
    }
}
