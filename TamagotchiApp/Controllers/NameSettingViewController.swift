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
    
    var nickName: String = ""
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(nickName)
        
        
        designTextField()
        rightBarButtonItem()
        
        title = "\(userDefaults.string(forKey: "nickname") ?? "")님 이름 정하기"
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
        navigationItem.rightBarButtonItem?.tintColor = .lightGray
    }
    
    @objc func saveButtonClicked() {
        print(#function)
        guard let nickname = nameChangeTextField.text else { return }
        userDefaults.set(nickname, forKey: "nickname")
        nameChangeTextField.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    func designTextField() {
        nameChangeTextField.designTextField()
        nameChangeTextField.placeholder = ""
        nameChangeTextField.textAlignment = .left
    }
    


}
