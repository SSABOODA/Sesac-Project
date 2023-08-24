//
//  GenericViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit
import SnapKit

class GenericViewController: UIViewController {
    
    let sampleLabel = UILabel()
    let sampleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        let generic = sum(a: 5.3, b: 5)
        print(generic)
        
        let value = sumInt(a: 3, b: 7)
        print(value)
        
        let value2 = sumDouble(a: 3.5, b: 7.2)
        print(value2)
        
        title = "네비게이션 타이틀"
        
        view.addSubview(sampleLabel)
        sampleLabel.backgroundColor = .yellow
        sampleLabel.text = "제네릭 테스트"
        configureBorder(view: sampleLabel)
        sampleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(50)
        }
        
        view.addSubview(sampleButton)
        sampleButton.backgroundColor = .yellow
        configureBorder(view: sampleButton)
        sampleButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.top.equalTo(sampleLabel.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }
    }
}
