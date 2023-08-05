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
    let profile = ProfileInfo()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePopUpView()
        designPopUpView()
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
        
        guard let  index = tamagotchi.imageName.first else { return }
        let currentImageName = "\(String(index))-\(tamagotchi.level)"
        let nickName = userDefaults.string(forKey: "nickname")
        userDefaults.set(Int(String(index))!, forKey: "index")
        userDefaults.set(nickName, forKey: "nickname")
        userDefaults.set(currentImageName, forKey: "imageName")
        userDefaults.set(tamagotchi.name, forKey: "name")
        userDefaults.set(tamagotchi.level, forKey: "level")
        userDefaults.set(tamagotchi.rice, forKey: "rice")
        userDefaults.set(tamagotchi.water, forKey: "water")
        changeRootScene()
    }
    
    func notReadyTamagotchiAlert() {
        let alert = UIAlertController(title: "아직 준비중이에요 다음에 만나요", message: "", preferredStyle: .alert)
                
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인 버튼이 눌렀습니다.")
        }
        alert.addAction(success)

        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 구현 함수
    
    func changeRootScene() {
        userDefaults.set(true, forKey: "isSelected")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKey()
    }

    
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
            item.tintColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        }
        popUpCancelButton.backgroundColor = .systemGray6
        
        // button stackview design
        buttonStackView.layer.borderColor = UIColor.systemGray5.cgColor
        buttonStackView.layer.borderWidth = 0.8
    }
    

}
