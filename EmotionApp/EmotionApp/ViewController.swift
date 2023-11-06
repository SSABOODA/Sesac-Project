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
            UserDefaultsManager.happy = happy
            print("완전행복지수: \(happy)점")
        case .good:
            score == 0 ? (good = EmotionScore.reset.rawValue) : (good += score)
            UserDefaultsManager.good = good
            print("적당미소지수: \(good)점")
        case .nomal:
            score == 0 ? (nomal = EmotionScore.reset.rawValue) : (nomal += score)
            UserDefaultsManager.nomal = nomal
            print("그냥그냥지수: \(nomal)점")
        case .upset:
            score == 0 ? (upset = EmotionScore.reset.rawValue) : (upset += score)
            UserDefaultsManager.upset = upset
            print("좀속상한지수: \(upset)점")
        case .depressed:
            score == 0 ? (depressed = EmotionScore.reset.rawValue) : (depressed += score)
            UserDefaultsManager.depressed = depressed
            print("많이슬픈지수: \(depressed)점")
        }
    }
    
    func getUserDefaults() {
        happy = UserDefaultsManager.happy
        good = UserDefaultsManager.good
        nomal = UserDefaultsManager.nomal
        upset = UserDefaultsManager.upset
        depressed = UserDefaultsManager.depressed
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        addEmotionScore(sender, EmotionScore.one.rawValue)
    }
}
