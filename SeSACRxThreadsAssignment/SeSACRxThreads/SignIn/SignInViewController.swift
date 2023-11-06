//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        bind()
    }
    
    func bind() {
        let email = emailTextField.rx.text.orEmpty
        let password = passwordTextField.rx.text.orEmpty
        
        let validation = Observable
            .combineLatest(email, password) { e, p in
                return e.count > 8 && p.count >= 6
            }
            
        validation
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation
            .subscribe(with: self) { owner, value in
                owner.signInButton.backgroundColor = value ? UIColor.systemBlue : UIColor.systemRed
                owner.emailTextField.layer.borderColor = value ? UIColor.systemBlue.cgColor : UIColor.systemRed.cgColor
                owner.passwordTextField.layer.borderColor = value ? UIColor.systemBlue.cgColor : UIColor.systemRed.cgColor
            }
            .disposed(by: disposeBag)

        signInButton.rx.tap
            .subscribe(with: self) { owner, value in
                owner.navigationController?.pushViewController(ViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func exampleSubject() {
        let subject = ReplaySubject<Int>.create(bufferSize: 3)
//        subject.onNext(20)
//        subject.onNext(30)
//        subject.onNext(40)
        subject.onNext(50)
        subject.onNext(60)
        
        subject
            .subscribe(with: self) { owner, value in
                print("ReplaySubject next - \(value)")
            } onError: { owner, error in
                print("ReplaySubject error - \(error)")
            } onCompleted: { owner in
                print("ReplaySubject onCompleted")
            } onDisposed: { owner in
                print("ReplaySubject onDisposed")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(3)
        subject.onNext(4)
        subject.on(.next(10))
        subject.onCompleted()
        subject.onNext(15)
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
