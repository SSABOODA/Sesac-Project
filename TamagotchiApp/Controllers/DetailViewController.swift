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
    
    var tamagotchiInfo = TamagotchiInformation()
    
    var nickname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialDetailView()
        configureDetailView()

        designDetailView()
        designLevelLabel()
        designRightBarButtonItem()
        designTextField(riceTextField)
        designTextField(waterTextField)
        backBarButtonItem()
        navigationTitleColor()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(nicknameNotificationObserver(notification:)),
            name: NSNotification.Name("nickname"),
            object: nil
        )
        
    }
    
    @objc func nicknameNotificationObserver(notification: NSNotification) {
        if let nickname = notification.userInfo?["nickname"] as? String {
            print("DetailView nickname", nickname)
            title = "\(nickname)님의 다마고치"
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        configureDetailView()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        configureDetailView()
//    }
 
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func eatRiceTextFieldClicked(_ sender: UITextField) {
    }
    
    @IBAction func eatWaterTextFieldClicked(_ sender: UITextField) {
    }
    
    @IBAction func eatButtonClicked(_ sender: UIButton) {
        sender.tag == 0 ? eatCalculator(key: .rice) : eatCalculator(key: .water)
        
        let level = UserDefaultsHelper.shared.level
        let rice = UserDefaultsHelper.shared.rice
        let water = UserDefaultsHelper.shared.water
        tamagotchiLevelLabel.text = "LV\(level) · 밥알 \(rice)개 · 물방울 \(water)개"
        checkTamagotchiLevel()
    }
    
    // 먹이주기 계산 함수
    func eatCalculator(key: UserDefaultsHelper.Key) {
        
        switch key {
        case .rice:
            var upCount: Int = UserDefaultsHelper.shared.rice
            do {
                upCount += try checkEatLimit(riceTextField, 100)
                UserDefaultsHelper.shared.rice = upCount
            } catch {
                print("EAT RICE ERROR")
            }
        case .water:
            var upCount: Int = UserDefaultsHelper.shared.water
            
            do {
                upCount += try checkEatLimit(waterTextField, 50)
                UserDefaultsHelper.shared.water = upCount
            } catch {
                print("EAT WATER ERROR")
            }
        default:
            return
        }
    }
    
    func checkEatLimit(_ textField: UITextField, _ limit: Int) throws -> Int {
        var result = 0
        
        guard let text = textField.text else {
            throw ValidationError.isEmptyText
        }
        
        if text.isEmpty {
            textField.text = ""
            result = 1
            return result
        }
        
        guard let num = Int(text) else {
            throw ValidationError.isNotInt
        }
    
        result = num >= limit ? 0 : num
        return result
    }
    
    // 레벨 계산
    func checkTamagotchiLevel() {
        let riceCount = UserDefaultsHelper.shared.rice
        let waterCount = UserDefaultsHelper.shared.water
        let beforelevel = UserDefaultsHelper.shared.level
        
        let resultLevel = Int((Double(riceCount) / 5.0) + (Double(waterCount) / 2.0)) + 1
        let currentLevel: Int = resultLevel > 10 ? 10 : resultLevel

        UserDefaultsHelper.shared.level = currentLevel
        if beforelevel != currentLevel {
            randomBubbleSpeechText()
            configureDetailView()
        }

    }
    
    func randomBubbleSpeechText() {
        speechBubbleLabel.text = tamagotchiInfo.randomTamagotchiSpeechContent()
    }
    
    func saveImageName() {
        let index = UserDefaultsHelper.shared.index
        let level = UserDefaultsHelper.shared.level
        let currentImageName: String = level == 10 ? "\(String(index))-\(level-1)" : "\(String(index))-\(level)"
        UserDefaultsHelper.shared.imageName = currentImageName
    }
    
    // detail view 구성
    func configureDetailView() {
        title = "\(UserDefaultsHelper.shared.nickname)님의 다마고치"
        
        let level = UserDefaultsHelper.shared.level
        let rice = UserDefaultsHelper.shared.rice
        let water = UserDefaultsHelper.shared.water
        let name = UserDefaultsHelper.shared.name
        saveImageName()
        let imageName = UserDefaultsHelper.shared.imageName
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
