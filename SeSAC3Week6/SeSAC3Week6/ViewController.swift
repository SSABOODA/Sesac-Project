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
    // 1. isActive
    // 2. addConstraints
// => NsLayoutAnchor

class ViewController: UIViewController {

//    let emailTextField = {
//        let tf = UITextField()
//        tf.backgroundColor = .lightGray
//        tf.isSecureTextEntry = true
//        tf.keyboardType = .numberPad
//        tf.placeholder = "닉네임을 입력해주세요"
//        return tf
//    }()
    
//    let passwordTextFied = UITextField()
    let signButton = {
        let bnt = UIButton()
        bnt.backgroundColor = .systemBlue
        bnt.setTitle("버튼", for: .normal)
        bnt.setTitleColor(.white, for: .normal)
        bnt.layer.cornerRadius = 10
        return bnt
    }()
    let mapKitButton = {
        let bnt = UIButton()
        bnt.backgroundColor = .systemBlue
        bnt.setTitle("MapKit과제로 이동", for: .normal)
        bnt.setTitleColor(.white, for: .normal)
        bnt.layer.cornerRadius = 10
        return bnt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(emailTextField) // frame 기반
//        view.addSubview(passwordTextFied) // AutoLayout
        view.addSubview(signButton)
        view.addSubview(mapKitButton)
        
        setLayoutAnchor() // signButton => NsLayoutAnchor
        
//        passwordTextFied.translatesAutoresizingMaskIntoConstraints = false
        
//        emailTextField.frame = CGRect(
//            x: 50,
//            y: 80,
//            width: UIScreen.main.bounds.width - 100,
//            height: 50
//        )
        
        //addConstraints
//        let leading = NSLayoutConstraint(item: passwordTextFied, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
//        let trailing = NSLayoutConstraint(item: passwordTextFied, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
//        let height = NSLayoutConstraint(item: passwordTextFied, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
//        let top = NSLayoutConstraint(item: passwordTextFied, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50)
//
//        view.addConstraints([leading, trailing, height, top])
        
//        NSLayoutConstraint(item: passwordTextFied, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextFied, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextFied, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
//
//        NSLayoutConstraint(item: passwordTextFied, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
//        passwordTextFied.backgroundColor = .brown
 
    }
    
    @objc
    func signButtonClicked() {
//        let vc = SnapKitViewController()
//        let vc = TextViewController()
//        let vc = LocationViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        present(nav, animated: true)
        
        transition(viewController: GenericViewController.self, storyboard: "Main", style: .presentFullNavigation)
    }
    
    @objc
    func mapKitButtonClicked() {
        let vc = MapKitViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func setLayoutAnchor() {
        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        mapKitButton.addTarget(self, action: #selector(mapKitButtonClicked), for: .touchUpInside)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        mapKitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mapKitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapKitButton.widthAnchor.constraint(equalToConstant: 300),
            mapKitButton.heightAnchor.constraint(equalToConstant: 50),
            mapKitButton.bottomAnchor.constraint(equalTo: signButton.topAnchor, constant: -40)
        ])
    }
}
