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
        label.text = "NETFLIX"
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
    
    let signInButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.black, for: .normal)
        view.setTitle("회원가입", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
//        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
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
    
    var viewModel = SigninViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        bindData()
                
        emailTextField.addTarget(self, action: #selector(emailTextFieldClicked), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldClicked), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldClicked), for: .editingChanged)
        locationTextField.addTarget(self, action: #selector(locationTextFieldClicked), for: .editingChanged)
        recommendationTextField.addTarget(self, action: #selector(recommendationTextFieldClicked), for: .editingChanged)
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    private func bindData() {
        viewModel.email.bind { text in
            print("email bind text: \(text)")
        }
        
        viewModel.password.bind { text in
            print("password bind text: \(text)")
        }
        
        viewModel.nickname.bind { text in
            print("nickname bind text: \(text)")
        }
        
        viewModel.location.bind { text in
            print("location bind text: \(text)")
        }
        
        viewModel.recommendation.bind { text in
            print("recommendation bind text: \(text)")
        }
        
        viewModel.isVaild.bind { bool in
            print("isVaild bind: \(bool)")
            self.signInButton.isEnabled = bool
            self.signInButton.backgroundColor = bool == true ? .red : .white
        }
    }
    
    private func configureView() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(locationTextField)
        view.addSubview(recommendationTextField)
        view.addSubview(signInButton)
        
        view.addSubview(extraInfoLabel)
        view.addSubview(switchButton)
    }
    
    private func setConstraints() {
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
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recommendationTextField.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(280)
        }
        
        extraInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(15)
            make.leading.equalTo(signInButton.snp.leading)
        }
        
        switchButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(15)
            make.trailing.equalTo(signInButton.snp.trailing)
        }
        
        
    }
    
    @objc func emailTextFieldClicked() {
        print(#function)
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
        print(emailTextField.text!)
        
    }
    
    @objc func passwordTextFieldClicked() {
        print(#function)
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
        print(passwordTextField.text!)
        
    }
    
    @objc func nicknameTextFieldClicked() {
        print(#function)
        viewModel.nickname.value = nicknameTextField.text!
        viewModel.checkValidation()
        print(nicknameTextField.text!)
        
    }
    
    @objc func locationTextFieldClicked() {
        print(#function)
        viewModel.location.value = locationTextField.text!
        viewModel.checkValidation()
        print(locationTextField.text!)
        
    }
    
    @objc func recommendationTextFieldClicked() {
        print(#function)
        viewModel.recommendation.value = recommendationTextField.text!
        viewModel.checkValidation()
        print(recommendationTextField.text!)
    }
    
    @objc func signInButtonClicked() {
        if viewModel.isVaild.value {
            let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
}
