//
//  ViewController.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet var happyButton: UIButton!
    
    var happy: Int = 0
    var good: Int = 0
    var nomal: Int = 0
    var upset: Int = 0
    var depressed: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case Emotion.happy.rawValue:
            happy += 1
            print("완전행복지수: \(happy)점")
        case Emotion.good.rawValue:
            good += 1
            print("적당미소지수: \(good)점")
        case Emotion.nomal.rawValue:
            nomal += 1
            print("그냥그냥지수: \(nomal)점")
        case Emotion.upset.rawValue:
            upset += 1
            print("좀속상한지수: \(upset)점")
        case Emotion.depressed.rawValue:
            depressed += 1
            print("많이슬픈지수: \(depressed)점")
        default:
            print("nil")
        }
    }
}

