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
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullDownButton(emotionButtons)
        getUserDefaults()
        designButtons()
    }
    
    func pullDownButton(_ emotionButtons: [UIButton]) {
        
        emotionButtons.forEach { item in
            let score1 = UIAction(title: EmotionScoreText.one.rawValue, handler: { _ in self.addEmotionScore(item, EmotionScore.one.rawValue) })
            let score5 = UIAction(title: EmotionScoreText.five.rawValue, handler: { _ in self.addEmotionScore(item, EmotionScore.five.rawValue) })
            let score10 = UIAction(title: EmotionScoreText.ten.rawValue, handler: { _ in self.addEmotionScore(item, EmotionScore.ten.rawValue) })
            let scoreReset = UIAction(title: EmotionScoreText.reset.rawValue, handler: { _ in self.addEmotionScore(item, EmotionScore.reset.rawValue) })
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
            score == 0 ? (happy = EmotionScore.reset.rawValue) : (happy += score)
            setUserDefault(happy, "\(value)")
            print("완전행복지수: \(happy)점")
        case .good:
            score == 0 ? (good = EmotionScore.reset.rawValue) : (good += score)
            setUserDefault(good, "\(value)")
            print("적당미소지수: \(good)점")
        case .nomal:
            score == 0 ? (nomal = EmotionScore.reset.rawValue) : (nomal += score)
            setUserDefault(nomal, "\(value)")
            print("그냥그냥지수: \(nomal)점")
        case .upset:
            score == 0 ? (upset = EmotionScore.reset.rawValue) : (upset += score)
            setUserDefault(upset, "\(value)")
            print("좀속상한지수: \(upset)점")
        case .depressed:
            score == 0 ? (depressed = EmotionScore.reset.rawValue) : (depressed += score)
            setUserDefault(depressed, "\(value)")
            print("많이슬픈지수: \(depressed)점")
        }
    }
    
    func setUserDefault(_ totalScore:Int, _ key:String) {
        userDefault.set(totalScore, forKey: key)
    }
    
    func getUserDefaults() {
        happy = userDefault.integer(forKey: "happy")
        good = userDefault.integer(forKey: "good")
        nomal = userDefault.integer(forKey: "nomal")
        upset = userDefault.integer(forKey: "upset")
        depressed = userDefault.integer(forKey: "depressed")
    }
    
    
    func designButtons() {
        emotionButtons.forEach { item in
//            item.showsTouchWhenHighlighted = true
        }
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        addEmotionScore(sender, EmotionScore.one.rawValue)
    }
}

