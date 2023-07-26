//
//  ViewController.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emotionButtons: [UIButton]!
    
    var happy: Int = 0
    var good: Int = 0
    var nomal: Int = 0
    var upset: Int = 0
    var depressed: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullDownButton(emotionButtons)
    }
    
    func pullDownButton(_ emotionButtons: [UIButton]) {
        
        emotionButtons.forEach { item in
            let score1 = UIAction(title: "1점 주기", handler: { _ in self.addEmotionScore(item, 1) })
            let score5 = UIAction(title: "5점 주기", handler: { _ in self.addEmotionScore(item, 5) })
            let score10 = UIAction(title: "10점 주기", handler: { _ in self.addEmotionScore(item, 10) })
            let scoreReset = UIAction(title: "점수 리셋 하기", handler: { _ in self.addEmotionScore(item, 0) })
            item.menu = UIMenu(title: "\(Emotion(rawValue: item.tag)!)의 점수 선택하기",
                                        image: UIImage(systemName: "heart"),
                                        identifier: nil,
                                        options: .displayInline,
                                        children: [score1, score5, score10, scoreReset])
        }
    }
    
    func addEmotionScore(_ button: UIButton, _ score: Int) {
        
        guard let value = Emotion(rawValue: button.tag) else {
            print("오류가 발생했습니다.")
            return
        }
        
        switch value {
        case .happy:
            score == 0 ? (happy = 0) : (happy += score)
            UserDefaults.standard.set(happy, forKey: "\(Emotion(rawValue: button.tag)!)")
            print("완전행복지수: \(happy)점")
        case .good:
            score == 0 ? (good = 0) : (good += score)
            UserDefaults.standard.set(good, forKey: "\(Emotion(rawValue: button.tag)!)")
            print("적당미소지수: \(good)점")
        case .nomal:
            score == 0 ? (nomal = 0) : (nomal += score)
            UserDefaults.standard.set(nomal, forKey: "\(Emotion(rawValue: button.tag)!)")
            print("그냥그냥지수: \(nomal)점")
        case .upset:
            score == 0 ? (upset = 0) : (upset += score)
            UserDefaults.standard.set(upset, forKey: "\(Emotion(rawValue: button.tag)!)")
            print("좀속상한지수: \(upset)점")
        case .depressed:
            score == 0 ? (depressed = 0) : (depressed += score)
            UserDefaults.standard.set(depressed, forKey: "\(Emotion(rawValue: button.tag)!)")
            print("많이슬픈지수: \(depressed)점")
        }
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        addEmotionScore(sender, 1)
    }
}

