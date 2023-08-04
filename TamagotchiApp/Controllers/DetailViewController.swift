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

        configureDetailView()
        designDetailView()
        
        designLevelLabel()
        designRightBarButtonItem()
        
        title = "대장님의 다마고취"
    }
    
    override func viewDidLayoutSubviews() {
        designTextField(riceTextField)
        designTextField(waterTextField)
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
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
}
