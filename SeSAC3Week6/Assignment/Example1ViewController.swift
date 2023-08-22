//
//  Example1ViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit
import SnapKit

class Example1ViewController: UIViewController {
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.placeholder = "제목을 입력해주세요"
        tf.textAlignment = .center
        return tf
    }()
    
    let dateTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.placeholder = "날짜를 입력해주세요"
        tf.textAlignment = .center
        return tf
    }()
    
    let memoTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.borderWidth = 1
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(topView)
        view.addSubview(titleTextField)
        view.addSubview(dateTextField)
        view.addSubview(memoTextView)
        
        setConstraints()
    }
    
    func setConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(300)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(30)
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(30)
            make.top.equalTo(titleTextField.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(30)
            make.top.equalTo(dateTextField.snp.bottom).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}
