//
//  Task1ViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit
import SnapKit

class TaskViewController: UIViewController {
    
    let nextExample1MoveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to Example1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    let nextExample2MoveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to Example2", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    let nextExample3MoveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to Example3", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(nextExample1MoveButton)
        view.addSubview(nextExample2MoveButton)
        view.addSubview(nextExample3MoveButton)
        
        
        setConstraints()
        
        nextExample1MoveButton.addTarget(self, action: #selector(nextExample1MoveButtonClicked), for: .touchUpInside)
        
        nextExample2MoveButton.addTarget(self, action: #selector(nextExample2MoveButtonClicked), for: .touchUpInside)
        
        nextExample3MoveButton.addTarget(self, action: #selector(nextExample3MoveButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func nextExample1MoveButtonClicked() {
        let vc = Example1ViewController()
        present(vc, animated: true)
    }
    
    @objc func nextExample2MoveButtonClicked() {
        let vc = Example2ViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func nextExample3MoveButtonClicked() {
        let vc = Example3ViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func setConstraints() {
        nextExample1MoveButton.snp.makeConstraints { make in
            make.top.equalTo(300)
            make.leading.equalTo(100)
            make.trailing.equalTo(-100)
            make.height.equalTo(50)
        }
        
        nextExample2MoveButton.snp.makeConstraints { make in
            make.top.equalTo(nextExample1MoveButton.snp.bottom).offset(50)
            make.leading.equalTo(100)
            make.trailing.equalTo(-100)
            make.height.equalTo(50)
        }
        
        nextExample3MoveButton.snp.makeConstraints { make in
            make.top.equalTo(nextExample2MoveButton.snp.bottom).offset(50)
            make.leading.equalTo(100)
            make.trailing.equalTo(-100)
            make.height.equalTo(50)
        }
    }


}
