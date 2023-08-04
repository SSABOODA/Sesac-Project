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

        if tamagotchi != nil {
            if let num = tamagotchi!.imageName.first {
                tamagotchi!.imageName = "\(String(num))-\(tamagotchi!.level)"
            }
            changeRootScene(tamagotchi!)
        }
    }
    
    // MARK: - 구현 함수
    
    func changeRootScene(_ data: Tamagotchi) {
        UserDefaults.standard.set(true, forKey: "isStart")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        vc.tamagotchi = data
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
