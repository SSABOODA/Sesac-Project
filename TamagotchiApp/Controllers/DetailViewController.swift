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
    
    var tamagotchi: Tamagotchi?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveUserDefalutData()

        configureDetailView()
        designDetailView()
        designLevelLabel()
        designRightBarButtonItem()
        
        title = "대장님의 다마고취"
        
        
    }
    
    func saveUserDefalutData() {
        if tamagotchi != nil {
            
            tamagotchi!.rice = UserDefaults.standard.integer(forKey: "riceCount")
            tamagotchi!.water = UserDefaults.standard.integer(forKey: "waterCount")
            tamagotchi!.imageName = UserDefaults.standard.string(forKey: "imageName") ?? tamagotchi!.imageName
            tamagotchi!.level = UserDefaults.standard.integer(forKey: "level")
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
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
    
    @IBAction func eatRiceButtonClicked(_ sender: UIButton) {
        if tamagotchi != nil {
            guard let text = riceTextField.text else { return }
            if !text.isEmpty && (Int(text) != nil) {
                tamagotchi!.rice += Int(text)!
            } else {
                tamagotchi!.rice += 1
            }
            riceTextField.text = ""
            checkTamagotchiLevel(tamagotchi!)
            tamagotchiLevelLabel.text = tamagotchi!.currentLevelText
            UserDefaults.standard.set(tamagotchi!.rice, forKey: "riceCount")
        }
    }
    
    @IBAction func eatWaterButtonClicked(_ sender: UIButton) {
        if tamagotchi != nil {
            guard let text = waterTextField.text else { return }
            if !text.isEmpty && (Int(text) != nil) {
                tamagotchi!.water += Int(text)!
            } else {
                tamagotchi!.water += 1
            }
            waterTextField.text = ""
            checkTamagotchiLevel(tamagotchi!)
            tamagotchiLevelLabel.text = tamagotchi!.currentLevelText
            UserDefaults.standard.set(tamagotchi!.rice, forKey: "waterCount")
        }
    }
    
    func checkTamagotchiLevel(_ data: Tamagotchi) {
        
//        print("밥알: \(data.rice)")
//        print("물방울: \(data.water)")
        
        let riceCount = data.rice
        let waterCount = data.water
        let result = (Double(riceCount) / 5.0) + (Double(waterCount) / 2.0)
        print("result: \(result)")
        switch Int(result) {
        case 0..<10:
            tamagotchi?.level = 1
        case 10..<20:
            tamagotchi?.level = 1
        case 20..<30:
            tamagotchi?.level = 2
        case 30..<40:
            tamagotchi?.level = 3
        case 40..<50:
            tamagotchi?.level = 4
        case 50..<60:
            tamagotchi?.level = 5
        case 60..<70:
            tamagotchi?.level = 6
        case 70..<80:
            tamagotchi?.level = 7
        case 80..<90:
            tamagotchi?.level = 8
        case 90..<100:
            tamagotchi?.level = 9
        case 100...:
            tamagotchi?.level = 10
        default:
            tamagotchi?.level = 10
        }
        
        if tamagotchi != nil {
            UserDefaults.standard.set(tamagotchi!.level, forKey: "level")
            
            if let num = tamagotchi!.imageName.first {
                let imageNameString = "\(String(num))-\(tamagotchi!.level)"
                tamagotchiImageView.image = UIImage(named: imageNameString)
                UserDefaults.standard.set(imageNameString, forKey: "imageName")
            }
        }
    }
    
    func configureDetailView() {
        guard let tamagotchi else { return }
        speechBubbleImageView.image = UIImage(named: "bubble")
        tamagotchiImageView.image = UIImage(named: tamagotchi.imageName)
        tamagotchiNameLabel.text = tamagotchi.name
        tamagotchiLevelLabel.text = tamagotchi.currentLevelText
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
}
