//
//  TextViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {

    // 방법 3 -> 클로저
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemMint
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.placeholder = "날짜를 입력해주세요~"
        tf.textAlignment = .center
        tf.font = .boldSystemFont(ofSize: 15)
        return tf
    }()
    
    // 방법 1 -> lazy var 선언 X
//    static func setImageView() -> UIImageView {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemMint
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }
    
    // 방법 2 -> lazy var 선언 O
//    func setImageView() -> UIImageView {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemMint
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        
        let uiSet = [photoImageView, titleTextField]
        uiSet.forEach { view.addSubview($0) }
        
        setConstraints()
    }
    
    func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20) // == make.leading.equalTo(view).inset(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
