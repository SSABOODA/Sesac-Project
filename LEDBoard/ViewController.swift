//
//  ViewController.swift
//  LEDBoard
//
//  Created by 한성봉 on 2023/07/24.
//

import UIKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    @IBOutlet var mainTextFieldView: UIView!
    @IBOutlet var mainTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var colorButton: UIButton!
    @IBOutlet var mainTitleLabel: UILabel!
    
    var color: UIColor?
    let colorPickerVC = UIColorPickerViewController()
    let colorSet = [UIColor.purple, UIColor.red, UIColor.blue, UIColor.green, UIColor.white]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTextFieldView()
        designButton(buttonName: sendButton)
        designButton(buttonName: colorButton)
        
        colorPickerVC.delegate = self
    }
    
    // MARK: - IBAction
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        topViewIsHiddenToggle()
        
    }
    
    @IBAction func textFieldClicked(_ sender: UITextField) {
        settingTextAndColor()
        topViewIsHiddenToggle(false)
        
    }
    
    @IBAction func senderButtonTapped(_ sender: UIButton) {
        topViewIsHiddenToggle(false)
        settingTextAndColor()
    }
    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
//        randomTextColor() // random color function
        present(colorPickerVC, animated: true)
    }
    
    func settingTextAndColor() {
        mainTitleLabel.text = mainTextField.text
        guard let color = color else {
            print(#function, "문제가 발생 했습니다.")
            return
        }
        mainTitleLabel.textColor = color
        mainTextField.text = ""
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        color = viewController.selectedColor
        colorButton.tintColor = color
    }
    
    func randomTextColor() {
        mainTitleLabel.text = mainTextField.text
        mainTitleLabel.textColor = colorSet.randomElement()!
        colorButton.tintColor = colorSet.randomElement()!
    }
    
    func topViewIsHiddenToggle() {
        mainTextFieldView.isHidden.toggle()
        mainTextField.isHidden.toggle()
        sendButton.isHidden.toggle()
        colorButton.isHidden.toggle()
    }
    
    func topViewIsHiddenToggle(_ value: Bool) {
        if !value {
            mainTextFieldView.isHidden = true
            mainTextField.isHidden = true
            sendButton.isHidden = true
            colorButton.isHidden = true
        }
    }
    
    
    // MARK: - UI
    func designTextFieldView() {
        mainTextFieldView.layer.cornerRadius = 10
        mainTextFieldView.clipsToBounds = true
        
        mainTextField.layer.cornerRadius = 10
        mainTextField.clipsToBounds = true
        mainTextField.layer.borderWidth = 1
        mainTextField.layer.borderColor = UIColor.white.cgColor
    }

    func designButton(buttonName name:UIButton) {
        name.layer.borderWidth = 2
        name.layer.borderColor = UIColor.black.cgColor
        name.layer.cornerRadius = 5
        name.clipsToBounds = true
    }


}

