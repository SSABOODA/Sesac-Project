//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/12.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        title = "출연/제작"
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}


