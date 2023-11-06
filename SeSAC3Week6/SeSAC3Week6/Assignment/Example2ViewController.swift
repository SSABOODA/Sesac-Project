//
//  Example2ViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit

class Example2ViewController: UIViewController {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let giftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gift"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let qrButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "qrcode"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // 아래쪽
    
    let chatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "나와의 채팅"
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let editProfileLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "프로필 편집"
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    let storyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "quote.closing"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let storyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "카카오 스토리"
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .brown
        imageView.image = UIImage(named: "character")
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "SSABOO"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let profileStatusLable: UILabel = {
        let label = UILabel()
        label.text = "iOS 개발자 입니다."
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        
        
        let uiSet = [
            backButton,
            settingButton,
            qrButton,
            giftButton,
            
            editProfileButton,
            editProfileLabel,
            chatButton,
            chatLabel,
            storyButton,
            storyLabel,
            lineView,
            
            profileImageView,
            profileNameLabel,
            profileStatusLable,
        ]
        uiSet.forEach { view.addSubview($0) }
        setConstraints()
        
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }

    func setConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        qrButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.trailing.equalTo(settingButton.snp.leading).offset(-10)
        }
        
        giftButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.trailing.equalTo(qrButton.snp.leading).offset(-10)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
        
        editProfileLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(editProfileButton.snp.bottom).offset(15)
        }
        
        chatButton.snp.makeConstraints { make in
            make.top.equalTo(editProfileButton)
            make.trailing.equalTo(editProfileButton.snp.leading).offset(-80)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(editProfileLabel)
            make.centerX.equalTo(chatButton)
        }
        
        storyButton.snp.makeConstraints { make in
            make.top.equalTo(editProfileButton)
            make.leading.equalTo(editProfileButton.snp.trailing).offset(80)
        }
        
        storyLabel.snp.makeConstraints { make in
            make.top.equalTo(editProfileLabel)
            make.centerX.equalTo(storyButton)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(editProfileButton.snp.top).offset(-20)
            make.horizontalEdges.equalTo(view)
        }
        
        
        profileStatusLable.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(lineView.snp.top).offset(-40)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(profileStatusLable.snp.top).offset(-15)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(profileNameLabel.snp.top).offset(-15)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        

        
        
    }
    
    
}
