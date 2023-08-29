//
//  ProfileViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        view = mainView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func cancelButtonClicked() {
        
    }
    
    @objc func doneButtonClicked() {
        
    }
    
    @objc func modifyNameButtonClicked() {
        let vc = NameSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func modifyUserNameButtonClicked() {
        let vc = UserNameSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func modifygenderPronounButtonClicked() {
        let vc = GenderSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        title = "프로필 편집"
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        
        mainView.modifyNameButton.addTarget(self, action: #selector(modifyNameButtonClicked), for: .touchUpInside)
        mainView.modifyUserNameButton.addTarget(self, action: #selector(modifyUserNameButtonClicked), for: .touchUpInside)
        mainView.modifygenderPronounButton.addTarget(self, action: #selector(modifygenderPronounButtonClicked), for: .touchUpInside)
        
    }
    
    override func setConstraints() {
        
    }
    
}
