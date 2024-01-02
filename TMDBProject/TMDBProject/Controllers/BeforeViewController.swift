//
//  BeforeViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class BeforeViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "넘길 데이터를 입력해주세요"
        view.textAlignment = .center
        return view
    }()

    let nextButton = {
        let bnt = UIButton()
        bnt.setTitle("다음 화면으로 이동", for: .normal)
        bnt.backgroundColor = .systemBlue
        bnt.layer.cornerRadius = 10
        bnt.clipsToBounds = true
        return bnt
    }()
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(textField)
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let vc = NextViewController()
        vc.textData = textField.text!
        present(vc, animated: true)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
