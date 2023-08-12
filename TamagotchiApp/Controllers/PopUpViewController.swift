//
//  PopUpViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var tamagotchiNameLabel: UILabel!
    @IBOutlet var tamagotchiDescriptionLabel: UILabel!
    
    @IBOutlet var popUpCancelButton: UIButton!
    @IBOutlet var popUpStartButton: UIButton!
    @IBOutlet var buttonStackView: UIStackView!
    
    var tamagotchi: Tamagotchi?
    var dataTransitionType: DataTransitionType = .normal
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePopUpView()
        designPopUpView()
        
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
        
        // 설정에서 다마치고치 변경, 데이터 초기화 상황에 따라 데이터 초기값 설정 함수
        keepTamagotchiData()
        changeRootScene()
    }
    
    // MARK: - 구현 함수
    
    // 설정에서 다마치고치 변경, 데이터 초기화 상황에 따라 데이터 초기값 설정 함수
    func keepTamagotchiData() {
        switch dataTransitionType {
        case .normal:
            initialUserDefaultDataSetting()
        case .change:
            changeTamagotchiUserDefaultsDataSetting()
        case .reset:
            initialUserDefaultDataSetting()
        }
    }
    
    // 다마고치 데이터 userDefaults 저장
    func initialUserDefaultDataSetting() {
        guard let tamagotchi else { return }
        let level = tamagotchi.level
        let currentImageName = "\(String(self.index))-\(level)"
        UserDefaultsHelper.shared.index = self.index
        UserDefaultsHelper.shared.imageName = currentImageName
        UserDefaultsHelper.shared.name = tamagotchi.name
        UserDefaultsHelper.shared.level = tamagotchi.level
        UserDefaultsHelper.shared.rice = tamagotchi.rice
        UserDefaultsHelper.shared.water = tamagotchi.water
    }
    
    func changeTamagotchiUserDefaultsDataSetting() {
        guard let tamagotchi else { return }
        
        let level = UserDefaultsHelper.shared.level
        let rice = UserDefaultsHelper.shared.rice
        let water = UserDefaultsHelper.shared.water
        
        var currentImageName: String = ""
        if level == 10 {
            currentImageName = "\(String(self.index))-\(level-1)"
        } else {
            currentImageName = "\(String(self.index))-\(level)"
        }
        
        UserDefaultsHelper.shared.index = self.index
        UserDefaultsHelper.shared.imageName = currentImageName
        UserDefaultsHelper.shared.name = tamagotchi.name
        UserDefaultsHelper.shared.level = level
        UserDefaultsHelper.shared.rice = rice
        UserDefaultsHelper.shared.water = water
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
        UserDefaultsHelper.shared.isSelected = true
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
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
    
    // popup view 디자인
    func designPopUpView() {
        // background View 투명
        view.backgroundColor = UIColor.init(_colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
        view.isOpaque = false
        
        // name label design
        tamagotchiNameLabel.designNameTag()
        
        // popUpView design
        popUpView.layer.cornerRadius = 10
        popUpView.clipsToBounds = true
        popUpView.backgroundColor = ColorData.backgroundColor
        
        // button design
        let buttonList: [UIButton] = [popUpCancelButton, popUpStartButton]
        buttonList.forEach { item in
            item.tintColor = ColorData.fontColor
        }
        popUpCancelButton.backgroundColor = .systemGray6
        
        // button stackview design
        buttonStackView.layer.borderColor = UIColor.systemGray5.cgColor
        buttonStackView.layer.borderWidth = 0.8
    }
}
