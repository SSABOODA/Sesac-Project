//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let viewModel = PhoneViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        configureLayout()
        bind()
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.buttonEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.buttonEnabled
            .subscribe(with: self) { owner, value in
                owner.phoneTextField.tintColor = value ? UIColor.systemBlue : UIColor.systemRed
                owner.nextButton.backgroundColor = value ? UIColor.systemBlue : UIColor.systemRed
                owner.phoneTextField.layer.borderColor = value ? UIColor.systemBlue.cgColor : UIColor.systemRed.cgColor
            }
            .disposed(by: disposeBag)
        
        viewModel.phoneNumber
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        // orEmpty 자동으로 옵셔널 바인딩 해주는 operator
        phoneTextField.rx.text.orEmpty
            .subscribe(with: self) { owner, value in
                let result = value.formated(by: "###-####-####")
                owner.viewModel.phoneNumber.onNext(result)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
