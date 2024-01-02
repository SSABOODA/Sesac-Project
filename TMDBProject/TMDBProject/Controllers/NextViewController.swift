//
//  NextViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class NextViewController: BaseViewController {
    
    let label = {
        let lb = UILabel()
        lb.layer.cornerRadius = 10
        lb.layer.borderColor = UIColor.black.cgColor
        lb.layer.borderWidth = 1
        lb.backgroundColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    var textData: String = ""
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(label)
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = textData
    }
}
