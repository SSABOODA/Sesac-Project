//
//  WordViewController.swift
//  NewlyCoinedWord
//
//  Created by 한성봉 on 2023/07/21.
//

import UIKit

class WordViewController: UIViewController {

    @IBOutlet var wordTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var wordFirstButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(456)
//        wordFirstButton.titleLabel?.font = .systemFont(ofSize: 20)
//        wordFirstButton.titleLabel?.textColor = .black
        wordTextField.text = getRandomWord()
        getRandomWord() // 함수 반환값을 사용하지 않아도 경고가 나타나지 않는다.
        
//        wordFirstButton.isHidden = true // 사라짐
    }
    
    @discardableResult
    func getRandomWord() -> String {
        let random: [String] = ["고래밥", "칙촉", "썬칩", "포카칩", "월드콘", "메로나"]
        let result = random.randomElement()!
        return result
    }
    
    // 버튼 클릭 시 텍스트필드의 텍스트에 버튼 타이틀이 들어가는 기능
    @IBAction func wordButtonTapped(_ sender: UIButton) {
        wordTextField.text = sender.titleLabel?.text
        wordTextFieldClicked(wordTextField)
    }
    
    
    @IBAction func wordTextFieldClicked(_ sender: UITextField) {
        
        // Event -> DidEndOnExit
        // 키보드 return 입력시 키보드 비활성화
        print(#function)
        
//        if wordTextField.text == "별다줄" {
//            resultLabel.text = "별다줄: 별걸 다 줄인다."
//        } else if wordTextField.text == "알잘딱깔센" {
//            resultLabel.text = "알잘딱깔센: 알아서 잘 딱 깔끔하게 센스있게"
//        } else if wordTextField.text == "뉴진스" {
//            resultLabel.text = "뉴진스: ???????"
//        } else {
//            resultLabel.text = "찾는 결과가 없습니다."
//        }
        
        switch wordTextField.text?.lowercased() {
        case "별다줄": resultLabel.text = "별걸 다 줄인다."
        case "알잘딱깔센": resultLabel.text = "알아서 잘 딱 깔끔하게 센스있게"
        case "jmt": resultLabel.text = "JONNA 맛있다."
        default: resultLabel.text = "찾는 결과가 없습니다."
        }
        
        
        
    }
    

}
