//
//  BlackRadiusTextField.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit

class BlackRadiusTextField: UITextField {
    
    // Interface Builder를 사용하지 않고, UIView를 상속 받은 Custom Class를 코드로 구성할 때 사용되는 초기화 구문
    override init(frame: CGRect) { // UIView
        super.init(frame: frame)
        self.configureView()
    }
    
    // NSCoding
    // XIB -> NIB 변환 과정에서 객체 생성 시 필요한 init 구문 (storyboard)
    // Interface Builder에서 생성된 뷰들이 초기화될 때 실행되는 구문
    required init?(coder: NSCoder) { // NSCoding
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.borderStyle = .none
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.textColor = .black
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: 15)
    }
}

protocol ExampleProtocol {
    init(name: String)
}

class Mobile: ExampleProtocol {
    // required: 프로토콜에서 생성된 경우 사용하는 키워드
    // required Initializer (필수 생성자)
    required init(name: String) {}
}
