//
//  DetailViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    @IBOutlet var speechBubbleImageView: UIImageView!
    @IBOutlet var speechBubbleLabel: UILabel!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var tamagotchiNameLabel: UILabel!
    @IBOutlet var tamagotchiLevelLabel: UILabel!
    
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    
    let userDefault = UserDefaults.standard
    let speechBubbleContentList = [
        "레벨업 했어여~~~",
        "감사합니다.",
        "열심히 해보자구요",
        "오늘 날씨가 너무 덥네요",
        "건강 조심하세요",
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDetailView(false)
        designDetailView()
        designLevelLabel()
        designRightBarButtonItem()
        
        designTextField(riceTextField)
        designTextField(waterTextField)
    }
 
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func eatRiceTextFieldClicked(_ sender: UITextField) {
    }
    
    @IBAction func eatWaterTextFieldClicked(_ sender: UITextField) {
    }
    
    
    @IBAction func eatButtonClicked(_ sender: UIButton) {
        print("sender.tag: \(sender.tag)")
        sender.tag == 0 ? eatCalculator(riceTextField, "rice") : eatCalculator(waterTextField, "water")
        let level = userDefault.integer(forKey: "level")
        let rice = userDefault.integer(forKey: "rice")
        let water = userDefault.integer(forKey: "water")
        
        tamagotchiLevelLabel.text = "LV\(level) · 밥알 \(rice)개 · 물방울 \(water)개"
        checkTamagotchiLevel()
    }
    
    func eatCalculator(_ textField: UITextField, _ key: String) {
        var upCount: Int = userDefault.integer(forKey: key)
        if Int(textField.text!) != nil {
            let limitNum = key == "rice" ? 100 : 50
            if Int(textField.text!)! >= limitNum { return }
            upCount += Int(textField.text!)!
            textField.text = ""
        } else {
            upCount += 1
        }
        userDefault.set(upCount, forKey: key)
    }
  
    func checkTamagotchiLevel() {
        let riceCount = userDefault.integer(forKey: "rice")
        let waterCount = userDefault.integer(forKey: "water")
        
        let result = (Double(riceCount) / 5.0) + (Double(waterCount) / 2.0)
        print("result: \(result)")
        
        let beforelevel = userDefault.integer(forKey: "level")
        
        switch Int(result) {
        case 0..<10:
            userDefault.set(1, forKey: "level")
        case 10..<20:
            userDefault.set(1, forKey: "level")
        case 20..<30:
            userDefault.set(2, forKey: "level")
        case 30..<40:
            userDefault.set(3, forKey: "level")
        case 40..<50:
            userDefault.set(4, forKey: "level")
        case 50..<60:
            userDefault.set(5, forKey: "level")
        case 60..<70:
            userDefault.set(6, forKey: "level")
        case 70..<80:
            userDefault.set(7, forKey: "level")
        case 80..<90:
            userDefault.set(8, forKey: "level")
        case 90..<100:
            userDefault.set(9, forKey: "level")
        case 100...:
            userDefault.set(10, forKey: "level")
        default:
            userDefault.set(10, forKey: "level")
        }
        
        let index = userDefault.integer(forKey: "index")
        var level = userDefault.integer(forKey: "level")
        if level >= 10 { level = 9 }
        let currentImageName = "\(index)-\(level)"
        userDefault.set(currentImageName, forKey: "imageName")
        
        print(beforelevel, level)
        beforelevel != level ? configureDetailView(true) : configureDetailView(false)
    }
    
    func configureDetailView(_ diff: Bool) {
        title = "\(userDefault.string(forKey: "nickname")!)의 다마고치"
        
        speechBubbleImageView.image = UIImage(named: "bubble")
        
        speechBubbleLabel.text = diff == true ? speechBubbleContentList.randomElement()! : "안녕하세요 저는 방실방실 다마고치에여~~"
         
        guard let imageName = userDefault.string(forKey: "imageName") else { return }
        guard let name = userDefault.string(forKey: "name") else { return }
        tamagotchiImageView.image = UIImage(named: imageName)
        tamagotchiNameLabel.text = name
        
        let level = userDefault.integer(forKey: "level")
        let rice = userDefault.integer(forKey: "rice")
        let water = userDefault.integer(forKey: "water")
        
        tamagotchiLevelLabel.text = "LV\(level) · 밥알 \(rice)개 · 물방울 \(water)개"
    }
    
    func designDetailView() {
        tamagotchiNameLabel.designNameTag()
        riceTextField.placeholder = "밥주세요"
        waterTextField.placeholder = "물주세요"
        
        riceTextField.textAlignment = .center
        waterTextField.textAlignment = .center
     
        designButton(riceButton)
        designButton(waterButton)
    }
    
    func designLevelLabel() {
        tamagotchiLevelLabel.font = .boldSystemFont(ofSize: 13)
    }
    
    func designTextField(_ textField: UITextField) {
        textField.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(0.5)
        border.frame = CGRect(
            x: 0,
            y: textField.frame.size.height-width,
            width: textField.frame.size.width,
            height: textField.frame.size.height
        )
        border.backgroundColor = UIColor.systemGray2.cgColor
        textField.layer.addSublayer(border)
        textField.textAlignment = .center
        textField.textColor = UIColor.systemGray2
        textField.layer.masksToBounds = true
        
        textField.delegate = self
    }
    
    func designButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.layer.borderWidth = 2
        let color = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        button.setTitleColor(color, for: .normal)
        button.tintColor = color
    }
    
    func designRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
    }
}


extension DetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print(#function)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print(#function)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 2
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
