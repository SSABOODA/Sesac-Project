//
//  SignInTextField.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit

class SignInTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func configureView() {
        font = .systemFont(ofSize: 12)
        textAlignment = .center
        backgroundColor = .darkGray
        layer.cornerRadius = 8
        clipsToBounds = true
        textColor = .white
        tintColor = .white
        attributedPlaceholder = NSAttributedString(string: "플레이스 홀더 색상 바꾸기!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}
