//
//  File.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit


class MainViewMenuLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        textColor = .white
        font = .boldSystemFont(ofSize: 17)
    }
}
