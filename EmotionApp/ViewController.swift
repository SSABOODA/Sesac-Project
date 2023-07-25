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
        switch button.tag {
        case Emotion.happy.rawValue:
            score == 0 ? (happy = 0) : (happy += score)
            print("완전행복지수: \(happy)점")
            UserDefaults.standard.set(happy, forKey: "\(Emotion(rawValue: button.tag)!)")
        case Emotion.good.rawValue:
            score == 0 ? (good = 0) : (good += score)
            print("적당미소지수: \(good)점")
            UserDefaults.standard.set(good, forKey: "\(Emotion(rawValue: button.tag)!)")
        case Emotion.nomal.rawValue:
            score == 0 ? (nomal = 0) : (nomal += score)
            print("그냥그냥지수: \(nomal)점")
            UserDefaults.standard.set(nomal, forKey: "\(Emotion(rawValue: button.tag)!)")
        case Emotion.upset.rawValue:
            score == 0 ? (upset = 0) : (upset += score)
            print("좀속상한지수: \(upset)점")
            UserDefaults.standard.set(upset, forKey: "\(Emotion(rawValue: button.tag)!)")
        case Emotion.depressed.rawValue:
            score == 0 ? (depressed = 0) : (depressed += score)
            print("많이슬픈지수: \(depressed)점")
            UserDefaults.standard.set(depressed, forKey: "\(Emotion(rawValue: button.tag)!)")
        default:
            print("nil")
        }
        
        
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        addEmotionScore(sender, 1)
    }
}

