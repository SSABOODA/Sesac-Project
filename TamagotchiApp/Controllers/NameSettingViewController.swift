//
//  NameSettingViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/05.
//

import UIKit

class NameSettingViewController: UIViewController {

    static let identifier = "NameSettingViewController"
    
    @IBOutlet var nameChangeTextField: UITextField!
    
    let userDefaults = UserDefaults.standard
    var nickName: String = ""
    var profile = ProfileInfo()
    
    let placeholderText = "변경하실 닉네임을 입력헤주세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTextField()
        rightBarButtonItem()
        
        title = "\(userDefaults.string(forKey: "nickname") ?? "")님 이름 정하기"
        nameChangeTextField.delegate = self
    }
    
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func textFieldClicked(_ sender: UITextField) {
//        print(#function)
    }
    
    
    func rightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonClicked)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    }
    
    @objc func saveButtonClicked() {
        print(#function)
        guard let nickname = nameChangeTextField.text else { return }
        userDefaults.set(nickname, forKey: "nickname")
        profile.userProfile.nickName = nickname
        nameChangeTextField.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    func designTextField() {
        nameChangeTextField.designTextField()
        nameChangeTextField.textAlignment = .left
        nameChangeTextField.placeholder = placeholderText
        nameChangeTextField.text = nickName
    }
}

extension NameSettingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 6
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameChangeTextField.placeholder = "2글자 이상 6글자 이하로 작성해주세요~"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            nameChangeTextField.placeholder = placeholderText
        }
        
    }
}
