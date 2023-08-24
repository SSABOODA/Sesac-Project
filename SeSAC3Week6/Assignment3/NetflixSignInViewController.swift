//
//  NetFlixSignInViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit
import SnapKit

class NetflixSignInViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Netflix"
        label.font = .boldSystemFont(ofSize: 50)
        label.textColor = .systemRed
        return label
    }()
    
    let emailTextField = {
        let tf = SignInTextField()
        tf.placeholder = "이메일 주소 또는 전화번호"
        return tf
    }()
    
    let passwordTextField = {
        let tf = SignInTextField()
        tf.placeholder = "비밀번호"
        return tf
    }()
    
    let nicknameTextField = {
        let tf = SignInTextField()
        tf.placeholder = "닉네임"
        return tf
    }()
    
    let locationTextField = {
        let tf = SignInTextField()
        tf.placeholder = "위치"
        return tf
    }()
    
    let recommendationTextField = {
        let tf = SignInTextField()
        tf.placeholder = "추천 코드 입력"
        return tf
    }()
    
    let signInTextField = {
        let tf = UITextField()
        tf.text = "회원가입"
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.font = .boldSystemFont(ofSize: 13)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        tf.clipsToBounds = true
        return tf
    }()
    
    let extraInfoLabel = {
        let tf = UILabel()
        tf.text = "추가 정보 입력"
        tf.textColor = .white
        tf.font = .systemFont(ofSize: 13)
        return tf
    }()
    
    let switchButton = {
        let bnt = UISwitch()
        bnt.onTintColor = .systemRed
        return bnt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(locationTextField)
        view.addSubview(recommendationTextField)
        view.addSubview(signInTextField)
        
        view.addSubview(extraInfoLabel)
        view.addSubview(switchButton)
                
        setConstraints()

    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(150)
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        
        recommendationTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        
        signInTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recommendationTextField.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(280)
        }
        
        extraInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(signInTextField.snp.bottom).offset(15)
            make.leading.equalTo(signInTextField.snp.leading)
        }
        
        switchButton.snp.makeConstraints { make in
            make.top.equalTo(signInTextField.snp.bottom).offset(15)
            make.trailing.equalTo(signInTextField.snp.trailing)
        }
        
        
    }
}
