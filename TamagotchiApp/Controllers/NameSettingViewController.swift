//
//  NameSettingViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/05.
//

import UIKit

class NameSettingViewController: UIViewController {
    
    @IBOutlet var nameChangeTextField: UITextField!
    
    let userDefaults = UserDefaults.standard
    var nickName: String = ""
    var profile = ProfileInfo()
    
    let placeholderText = "변경하실 닉네임을 입력헤주세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTextField()
        rightBarButtonItem()
        
        self.view.backgroundColor = ColorData.backgroundColor
        title = "\(UserDefaultsHelper.shared.nickname)님 이름 정하기"
        nameChangeTextField.delegate = self
    }
    
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func textFieldClicked(_ sender: UITextField) {
    }
    
    
    func rightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonClicked)
        )
        navigationItem.rightBarButtonItem?.tintColor = ColorData.fontColor
    }
    
    @objc func saveButtonClicked() {
        guard let nickname = nameChangeTextField.text else { return }
        UserDefaultsHelper.shared.nickname = nickname
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
