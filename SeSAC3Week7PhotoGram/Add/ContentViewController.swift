//
//  ContentViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class ContentViewController: BaseViewController {
    
    let textField = {
        let view = UITextView()
        view.backgroundColor = .brown
//        view.placeholder = "  제목을 입력해주세요"
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 1
        return view
    }()
    
    // Closure - 1
    var completionHandler: ((String) -> Void)?
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Closure - 2
        completionHandler?(textField.text!)
    }
}
