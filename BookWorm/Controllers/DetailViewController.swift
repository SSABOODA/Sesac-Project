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
    
    let placeholderText = SearchBarPlaceHolder.detailViewController.rawValue

    @IBOutlet var detailMainImageView: UIImageView!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailRuntimeLabel: UILabel!
    @IBOutlet var detailRateLabel: UILabel!
    @IBOutlet var detailDescriptionLabel: UILabel!
    @IBOutlet var detailView: UIView!
    @IBOutlet var detailTextView: UITextView!
    
    var movie: Movie?
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetailView()
        configureTextView()
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
    
    func configureTextView() {
        detailTextView.delegate = self
        detailTextView.layer.borderWidth = 3
        detailTextView.layer.borderColor = UIColor.black.cgColor
        detailTextView.text = placeholderText
        detailTextView.textColor = .lightGray
    }
    
    func configureDetailView() {
        view.backgroundColor = .systemGray4
        guard let book else { return }
        if let imageURL = URL(string: book.thumbnail) {
            detailMainImageView.kf.setImage(with: imageURL)
        }
        detailTitleLabel.text = book.title
        detailRuntimeLabel.text = "\(String(book.price))원"
        detailRateLabel.text = book.status
        detailDescriptionLabel.text = book.desc
        
        detailDescriptionLabel.numberOfLines = 0
        detailView.layer.cornerRadius = 10
        detailView.clipsToBounds = true
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
}
