//
//  ViewController.swift
//  NewlyCoinedWord
//
//  Created by 한성봉 on 2023/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    
    @IBOutlet var wordButtons: [UIButton]!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var dotsLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    let newlyCoinedWord = [
        "꾸안꾸": "꾸민 듯 안 꾸민 듯",
        "내또출": "내일 또 출근",
        "일취월장": "일요일에 취하면 월요일에 장난아님",
        "스불재": "스스로 불러온 재앙",
        "억텐": "억지 텐션",
        "좋댓구알": "좋아요, 댓글, 구독, 알림설정",
        "핑프": "핑거 프린스",
    ]
    
    let tagWordList = [
        "스불재",
        "억텐",
        "좋댓구알",
        "핑프"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designSearchStackView()
        designSearchButton()
        designWordButton()
        designDescriptionView()
        
    }
    
    // MARK: - IBAction
    
    @IBAction func wordButtonTapped(_ sender: UIButton) {
        searchTextField.text = sender.titleLabel?.text
    }
    
    @IBAction func searchTextFieldClicked(_ sender: UITextField) {
        textFieldAlert(text: sender.text)
        findSearchWord()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        textFieldAlert(text: searchTextField.text)
        findSearchWord()
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldAlert(text inputText: String?) {
        if let text = inputText {
            if (text.isEmpty) || (text.count <= 1) {
                let alert = UIAlertController(title: "2글자 이상 입력해주세요 😭", message: "", preferredStyle: .alert)
                let success = UIAlertAction(title: "확인", style: .default) { action in
                    print("확인 버튼이 눌렀습니다.")
                    }
                alert.addAction(success)
                present(alert, animated: true)
            }
        }
    }
    
    func findSearchWord() {
        if searchTextField.text != nil {
            let word = newlyCoinedWord[searchTextField.text!, default: "찾는 단어가 없습니다."]
            descriptionLabel.text = word
            searchTextField.text = ""
        }
    }
    
    // MARK: - UI DESIGN

    func designSearchStackView() {
        searchStackView.layer.borderWidth = 3
        searchStackView.layer.borderColor = UIColor.black.cgColor
    }
    
    func designSearchButton() {
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
    }
    
    func designWordButton() {
        wordButtons.forEach { item in
            item.layer.borderWidth = 2
            item.layer.borderColor = UIColor.black.cgColor
            item.layer.cornerRadius = 8
            item.setTitleColor(.black, for: .normal)
            item.setTitle(tagWordList[item.tag], for: .normal)
        }
    }
    
    func designDescriptionView() {
        descriptionView.layer.borderWidth = 2
        descriptionView.layer.borderColor = UIColor.black.cgColor
        
        dotsLabel.layer.borderWidth = 2
        dotsLabel.layer.borderColor = UIColor.black.cgColor
        
        descriptionLabel.textAlignment = .center
    }

}

