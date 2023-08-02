//
//  DetailViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifer = "DetailViewController"

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
        checkNavigationPushViewController()
        
    }
    
    func checkNavigationPushViewController() {
        let vc = navigationController!.viewControllers[0]
        let classNameArr = NSStringFromClass(vc.classForCoder).split(separator: ".")
        beforeClassName = String(classNameArr[classNameArr.endIndex-1])
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
        if beforeClassName == BookCollectionViewController.identifier {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
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
