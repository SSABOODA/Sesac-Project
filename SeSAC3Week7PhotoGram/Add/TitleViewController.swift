//
//  TitleViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "  제목을 입력해주세요"
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    // Closure - 1
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        print(#function)
        
        completionHandler?(textField.text!, 77, false)
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Closure - 2
        completionHandler?(textField.text!, 9090, true)
    }
}
