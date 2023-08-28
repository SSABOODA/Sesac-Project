//
//  BaseViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
        print("Base configureView")
    }
    
    func setConstraints() {
        print("Base setConstraints")
    }
    
    

}
