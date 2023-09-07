//
//  BaseViewController.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
        
    }
    
    func configureView() {
        view.backgroundColor = .black
        print("Base configureView")
    }
    
    func setConstraints() {
        print("Base setConstraints")
    }
}
