//
//  GenderSettingViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class GenderSettingViewController: BaseViewController {

    let nameLabel = {
        let view = UILabel()
        view.text = "성별 대명사"
        view.textColor = .lightGray
        return view
    }()
    
    let nameTextField = {
        let view = UITextField()
        view.clearButtonMode = .always
        view.placeholder = "성별 대명사"
        return view
    }()
    
    @objc func doneButtonClicked() {
        print(#function)
    }

    override func configureView() {
        super.configureView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        
        title = "성별 대명사"
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
    }
    
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    

}
