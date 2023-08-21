//
//  ViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/21.
//

import UIKit

// Storyboard
// 1. 객체 올리고, 레이아웃 잡고, 아웃렛 연결, 속성 조절

// Code Base
// 1. 뷰 객체 프포러티 선언(클래스 인스턴스 생성)
// 2. 명시적으로 루트뷰에 추가 (+ translatesAutoresizingMaskIntoConstraints)
// 3. 크기와 위치 정의
// 4. 속성 정의
//=> Frame 한계
//=> AutoResizingMask, AutoLayout => 스토리보드 대응
//=> NSLayoutConstraints => 코드베이스 대응



class ViewController: UIViewController {

    var emailTextField = UITextField()
    var passwordTextFied = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextFied)
        
        passwordTextFied.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.frame = CGRect(
            x: 50,
            y: 80,
            width: UIScreen.main.bounds.width - 100,
            height: 50
        )
        
        emailTextField.backgroundColor = .lightGray
        emailTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .numberPad
        emailTextField.placeholder = "닉네임을 입력해주세요"
        
        NSLayoutConstraint(item: passwordTextFied, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true

        NSLayoutConstraint(item: passwordTextFied, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
        
        NSLayoutConstraint(item: passwordTextFied, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
        
        NSLayoutConstraint(item: passwordTextFied, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
        passwordTextFied.backgroundColor = .brown
        
    }


}

