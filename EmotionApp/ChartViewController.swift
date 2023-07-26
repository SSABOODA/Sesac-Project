//
//  ChartViewController.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/25.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet var charView: [UIView]!
    @IBOutlet var scoreLabel: [UILabel]!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designCharView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let emotionList = Emotion.allCases.map { userDefault.integer(forKey: "\($0)") }
        
        if scoreLabel.count == emotionList.count {
            for (label, emotionScore) in zip(scoreLabel, emotionList) {
                label.text = "\(emotionScore)점"
            }
        }
    }
    
    // MARK: - design

    func designCharView() {
        charView.forEach { item in
            item.layer.cornerRadius = 10
            item.clipsToBounds = true
        }
    }
}
