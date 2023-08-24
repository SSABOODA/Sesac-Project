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
    
    //1.
    let picker = UIImagePickerController()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //2. available
//        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//            print("갤러리 사용 불가, 사용자에게 트스트/얼럿")
//            // 갤러리 허용 설정 페이지 이동 로직 작성해야함.
//            return
//        }
//
//        // 카메러 사진 가져올 떄는 권한 요청 X
//        // 갤러리 이미지 추가, 삭제, 등은 권한 요청 O
//        picker.delegate = self
////        picker.sourceType =
//        picker.sourceType = .camera // 카메라 // .photoLibrary // 사진
//        picker.allowsEditing = true // 사진 찍고 -> 수정 허용할지
        
//        let picker = UIFontPickerViewController()
        let picker = UIColorPickerViewController()
        
        present(picker, animated: true)
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

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // UINavigationControllerDelegate => 이미지pickercontroller에는 이미 네비게이션 부분이 들어가있는데 커스텀하게 사용하고 싶다면 해당 프로토콜 채택
    
    // 취소 버튼 클릭 시 호출
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
    
    // 사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoImageView.image = image
            dismiss(animated: true)
        }
    }
    
}
