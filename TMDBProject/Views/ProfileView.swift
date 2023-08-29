//
//  ProfileView.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    // 프로필 이미지
    let profileImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(systemName: "person.circle")
        view.tintColor = .lightGray
        return view
    }()
    
    let avartarImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(systemName: "person.crop.circle.dashed")
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.tintColor = .lightGray
        return view
    }()
    
    // 사진 또는 아바타 수정
    
    let imageModifyButton = {
        let view = UIButton()
        view.setTitle("사진 또는 아바타 수정", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()
    
    // 구분선
    let separatorView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    // 이름
    let nameLabel = {
        let view = UILabel()
        view.text = "이름"
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        view.backgroundColor = .gray
        return view
    }()
    
    let nameTextField = {
        let view = UITextField()
        view.placeholder = "이름"
        view.font = .systemFont(ofSize: 16)
        view.backgroundColor = .gray
        return view
    }()
    
    let modifyNameButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.tintColor = .darkGray
        return view
    }()
    
    // 사용자 이름
    let userNameLabel = {
        let view = UILabel()
        view.text = "사용자 이름"
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let userNameTextField = {
        let view = UITextField()
        view.placeholder = "사용자 이름"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let modifyUserNameButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.tintColor = .darkGray
        return view
    }()
    
    // 성별 대명사
    let genderPronounLabel = {
        let view = UILabel()
        view.text = "성별 대명사"
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        return view
    }()

    let genderPronounTextField = {
        let view = UITextField()
        view.placeholder = "성별 대명사"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let modifygenderPronounButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.tintColor = .darkGray
        return view
    }()
    
    // 소개
    let introduceLabel = {
        let view = UILabel()
        view.text = "소개"
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        return view
    }()

    let introduceTextField = {
        let view = UITextField()
        view.placeholder = "소개"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    // 링크
    let linkLabel = {
        let view = UILabel()
        view.text = "링크"
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        return view
    }()

    let linkTextField = {
        let view = UITextField()
        view.placeholder = "링크"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    // 성별
    let genderLabel = {
        let view = UILabel()
        view.text = "성별"
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        return view
    }()

    let genderTextField = {
        let view = UITextField()
        view.placeholder = "성별"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    override func configureView() {
        addSubview(profileImageView)
        addSubview(avartarImageView)
        addSubview(imageModifyButton)
        
        addSubview(separatorView)
        
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(modifyNameButton)
        
        addSubview(userNameLabel)
        addSubview(userNameTextField)
        addSubview(modifyUserNameButton)
        
        addSubview(genderPronounLabel)
        addSubview(genderPronounTextField)
        addSubview(modifygenderPronounButton)
        
        addSubview(introduceLabel)
        addSubview(introduceTextField)
        addSubview(linkLabel)
        addSubview(linkTextField)
        addSubview(genderLabel)
        addSubview(genderTextField)
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview().offset(-60)
            make.size.equalTo(100)
        }
        
        avartarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview().offset(60)
            make.size.equalTo(100)
        }
        
        imageModifyButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(imageModifyButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(0)
            make.height.equalTo(1)
        }
        
        // 이름
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        modifyNameButton.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        // 사용자 이름
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        modifyUserNameButton.snp.makeConstraints { make in
            make.top.equalTo(modifyNameButton.snp.bottom).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        // 성별 대명사
        genderPronounLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        genderPronounTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        modifygenderPronounButton.snp.makeConstraints { make in
            make.top.equalTo(modifyUserNameButton.snp.bottom).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        // 소개
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(genderPronounLabel.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        introduceTextField.snp.makeConstraints { make in
            make.top.equalTo(genderPronounTextField.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        // 링크
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        linkTextField.snp.makeConstraints { make in
            make.top.equalTo(introduceTextField.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        // 성별
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.top.equalTo(linkTextField.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        
        
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        avartarImageView.layer.cornerRadius = avartarImageView.frame.width / 2
    }
    
    
}
