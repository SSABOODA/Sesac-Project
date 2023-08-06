//
//  PopUpViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class PopUpViewController: UIViewController {
    
    static let identifier = "PopUpViewController"
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var tamagotchiNameLabel: UILabel!
    @IBOutlet var tamagotchiDescriptionLabel: UILabel!
    
    @IBOutlet var popUpCancelButton: UIButton!
    @IBOutlet var popUpStartButton: UIButton!
    @IBOutlet var buttonStackView: UIStackView!
    
    var tamagotchi: Tamagotchi?
    let profile = ProfileInfo()
    let userDefaults = UserDefaults.standard
    var dataTransitionType: DataTransitionType = .normal
    
    var index: Int = 0
    
    let color = ColorData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePopUpView()
        designPopUpView()
        
        indexSetting()
        keepTamagotchiData()

    }
    
    @IBAction func tapGeustureTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func startButtonClicked(_ sender: UIButton) {

        guard let tamagotchi else { return }
        if tamagotchi.imageName == "noImage" {
            notReadyTamagotchiAlert()
            return
        }
        
        // popup view 데이터 세팅
        userDfaultDatSetting(tamagotchi)
        changeRootScene()
    }
    
    // MARK: - 구현 함수
    func indexSetting() {
        guard let tamagotchi else { return }
        guard let index = tamagotchi.imageName.first else { return }
        self.index = Int(String(index))!
        
        userDfaultDatSetting(tamagotchi)
    }
    
    func keepTamagotchiData() {
        switch dataTransitionType {
        case .normal:
            print("")
        case .change:
            if tamagotchi != nil {
                tamagotchi!.imageName = userDefaults.string(forKey: "imageName\(index)")!
                tamagotchi!.name = userDefaults.string(forKey: "name\(index)")!
                tamagotchi!.level = userDefaults.integer(forKey: "level")
                tamagotchi!.rice = userDefaults.integer(forKey: "rice")
                tamagotchi!.water = userDefaults.integer(forKey: "water")
            }
        case .reset:
            if tamagotchi != nil {
                tamagotchi!.imageName = userDefaults.string(forKey: "imageName\(index)")!
                tamagotchi!.name = userDefaults.string(forKey: "name\(index)")!
                tamagotchi!.level = 1
                tamagotchi!.rice = 0
                tamagotchi!.water = 0
            }
        }
    }
    
    func userDfaultDatSetting(_ tamagotchi: Tamagotchi) {
        let level = tamagotchi.level >= 10 ? 9 : tamagotchi.level
        let currentImageName = "\(String(index))-\(level)"
        let nickName = userDefaults.string(forKey: UserDefaultsKey.nickname.rawValue) ?? profile.userProfile.nickName
        userDefaults.set(nickName, forKey: UserDefaultsKey.nickname.rawValue) // profile nickname
        
        userDefaults.set(Int(String(index))!, forKey: UserDefaultsKey.index.rawValue)
        userDefaults.set(currentImageName, forKey: "\(UserDefaultsKey.imageName.rawValue)\(index)")
        userDefaults.set(tamagotchi.name, forKey: "\(UserDefaultsKey.name.rawValue)\(index)")
        userDefaults.set(tamagotchi.level, forKey: UserDefaultsKey.level.rawValue)
        userDefaults.set(tamagotchi.rice, forKey: UserDefaultsKey.rice.rawValue)
        userDefaults.set(tamagotchi.water, forKey: UserDefaultsKey.water.rawValue)
    }
    
    // 준비중인 다마고치 클릭 시 '준비 중' alert modal 띄우기
    func notReadyTamagotchiAlert() {
        let alert = UIAlertController(title: "아직 준비중이에요 다음에 만나요", message: "", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인 버튼이 눌렀습니다.")
        }
        alert.addAction(success)
        present(alert, animated: true, completion: nil)
    }
    
    // 다마고치 선택시 뷰 스택 DetailViewController로 초기화
    func changeRootScene() {
        userDefaults.set(true, forKey: "isSelected")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKey()
    }

    // popup view 구성
    func configurePopUpView() {
        guard let tamagotchi else { return }
        tamagotchiImageView.image = UIImage(named: tamagotchi.imageName)
        tamagotchiNameLabel.text = tamagotchi.name
        tamagotchiDescriptionLabel.text = tamagotchi.description
    }
    
    func designPopUpView() {
        // background View 투명
        view.backgroundColor = UIColor.init(_colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
        view.isOpaque = false
        
        // name label design
        tamagotchiNameLabel.designNameTag()
        
        // popUpView design
        popUpView.layer.cornerRadius = 10
        popUpView.clipsToBounds = true
        
        // button design
        let buttonList: [UIButton] = [popUpCancelButton, popUpStartButton]
        buttonList.forEach { item in
            item.tintColor = color.fontColor
        }
        popUpCancelButton.backgroundColor = .systemGray6
        
        // button stackview design
        buttonStackView.layer.borderColor = UIColor.systemGray5.cgColor
        buttonStackView.layer.borderWidth = 0.8
    }
    

}
