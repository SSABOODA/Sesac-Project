//
//  DetailViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit
import RealmSwift

final class DetailViewController: UIViewController {
    
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
    var task: BookTable?
    
    let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
    
    let bookRepository = BookTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetailView()
        configureTextView()
        designImageView()
        leftNavigationBarButtonItem()
        addToolbar()
    }
    
    private func addToolbar() {
        view.addSubview(toolbar)
        
        var toolbarItems: [UIBarButtonItem] = []
        
        let modify = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(modifyButtonClicked))
        let remove = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(removeButtonClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbarItems.append(modify)
        toolbarItems.append(flexibleSpace)
        toolbarItems.append(remove)
        
        toolbarItems.forEach { item in
            item.tintColor = .black
        }

        toolbar.setItems(toolbarItems, animated: true)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
    }
    
    @objc func modifyButtonClicked() {
        print("수정할래")
        guard let data = task else { return }
        
        bookRepository.updateItem(updateValue: [
            "_id": data._id,
            "memo": detailTextView.text!
        ])
        navigationController?.popViewController(animated: true)
    }
    
    @objc func removeButtonClicked() {
        print("삭제할래")
        removeAlert()
    }
    
    func removeAlert() {
        let alert = UIAlertController(title: "이 책을 정말 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            guard let data = self.task else { return }
            self.removeImageFromDocument(fileName: "book_\(data._id).jpg")
            self.bookRepository.deleteItem(data)
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }

    private func leftNavigationBarButtonItem() {
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
    
    private func designImageView() {
        detailMainImageView.backgroundColor = .clear
        detailMainImageView.layer.cornerRadius = 10
        detailMainImageView.clipsToBounds = true
    }
    
    private func configureTextView() {
        detailTextView.delegate = self
        detailTextView.layer.borderWidth = 3
        detailTextView.layer.borderColor = UIColor.black.cgColor
//        detailTextView.text = placeholderText
        detailTextView.textColor = .lightGray
    }
    
    private func configureDetailView() {
        view.backgroundColor = .systemGray4
        guard let task else { return }
        if let imageURL = URL(string: task.thumbnail) {
            detailMainImageView.kf.setImage(with: imageURL)
        }
        detailTitleLabel.text = task.title
        detailRuntimeLabel.text = "\(String(task.price))원"
        detailRateLabel.text = task.status
        detailDescriptionLabel.text = task.desc
        detailTextView.text = task.etc ?? ""
        
        detailDescriptionLabel.numberOfLines = 0
        detailView.layer.cornerRadius = 10
        detailView.clipsToBounds = true
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.text == placeholderText {
//            textView.text = nil
//            textView.textColor = .black
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = placeholderText
//            textView.textColor = .lightGray
//        }
    }
}
