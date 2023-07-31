//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSerchView()
        navBarButtonItem()
    }
    
    func configureSerchView() {
        title = "검색 화면"
    }
    
    func navBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

}
