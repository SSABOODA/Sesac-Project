//
//  DetailViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class DetailViewController: UIViewController {
    
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
    let profile = ProfileInfo()
    var tamagotchiInfo = TamagotchiInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialDetailView()
        configureDetailView(false)

        designDetailView()
        designLevelLabel()
        designRightBarButtonItem()
        designTextField(riceTextField)
        designTextField(waterTextField)
        backBarButtonItem()
        navigationTitleColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDetailView(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureDetailView(false)
    }
 
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func eatRiceTextFieldClicked(_ sender: UITextField) {
    }
    
    @IBAction func eatWaterTextFieldClicked(_ sender: UITextField) {
    }
    
    
    @IBAction func eatButtonClicked(_ sender: UIButton) {
        sender.tag == 0 ? eatCalculator(riceTextField, UserDefaultsKey.rice.rawValue) : eatCalculator(waterTextField, UserDefaultsKey.water.rawValue)
        
        let level = UserDefaultsHelper.shared.level
        let rice = UserDefaultsHelper.shared.rice
        let water = UserDefaultsHelper.shared.water
        tamagotchiLevelLabel.text = "LV\(level) · 밥알 \(rice)개 · 물방울 \(water)개"
        checkTamagotchiLevel()
    }
    
    // 먹이주기 계산 함수
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
  
    // 레벨 계산
    func checkTamagotchiLevel() {
        let riceCount = UserDefaultsHelper.shared.rice
        let waterCount = UserDefaultsHelper.shared.water
        
        let result = (Double(riceCount) / 5.0) + (Double(waterCount) / 2.0)
        let beforelevel = UserDefaultsHelper.shared.level
        
        var letUpNum: Int?
        switch Int(result) {
        case 0..<10:
            letUpNum = 1
        case 10..<20:
            letUpNum = 1
        case 20..<30:
            letUpNum = 2
        case 30..<40:
            letUpNum = 3
        case 40..<50:
            letUpNum = 4
        case 50..<60:
            letUpNum = 5
        case 60..<70:
            letUpNum = 6
        case 70..<80:
            letUpNum = 7
        case 80..<90:
            letUpNum = 8
        case 90..<100:
            letUpNum = 9
        case 100...:
            letUpNum = 10
        default:
            letUpNum = 10
        }
        
        guard let letUpNum else { return }
        UserDefaultsHelper.shared.level = letUpNum
        
        let index = UserDefaultsHelper.shared.index
        var level = UserDefaultsHelper.shared.level
        if level >= 10 { level = 9 }
        let currentImageName = "\(index)-\(level)"
        
        UserDefaultsHelper.shared.imageName = currentImageName
        beforelevel != level ? configureDetailView(true) : configureDetailView(false)
    }
    
    // detail view 구성
    func configureDetailView(_ diff: Bool) {
        
        title = "\(UserDefaultsHelper.shared.nickname)님의 다마고치"
        if diff {
            speechBubbleLabel.text = tamagotchiInfo.randomTamagotchiSpeechContent()
        }
        
        let level = UserDefaultsHelper.shared.level
        let rice = UserDefaultsHelper.shared.rice
        let water = UserDefaultsHelper.shared.water
        let imageName = UserDefaultsHelper.shared.imageName
        let name = UserDefaultsHelper.shared.name
        
        tamagotchiImageView.image = UIImage(named: imageName)
        tamagotchiNameLabel.text = name
        tamagotchiLevelLabel.text = "LV\(level) · 밥알 \(rice)개 · 물방울 \(water)개"
    }
    
    func initialDetailView() {
        speechBubbleImageView.image = UIImage(named: "bubble")
        speechBubbleLabel.text = "안녕하세요 저는 \(UserDefaultsHelper.shared.name)에요~~"
    }
    
    func backBarButtonItem() {
        let backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
        backBarButtonItem.tintColor = .lightGray
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func navigationTitleColor() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: ColorData.fontColor]
    }
    
    func designDetailView() {
        self.view.backgroundColor = ColorData.backgroundColor
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
        textField.designTextField()
        textField.delegate = self
    }
    
    func designButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = ColorData.fontColor.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(ColorData.fontColor, for: .normal)
        button.tintColor = ColorData.fontColor
    }
    
    func designRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem?.tintColor = ColorData.fontColor
    }
}

// MARK: - TextField Extension

extension DetailViewController: UITextFieldDelegate {
    
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
