//
//  EmotionEnum.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/25.
//

import Foundation


enum Emotion: Int, CaseIterable {
    case happy
    case good
    case nomal
    case upset
    case depressed
}

enum EmotionScoreText: String {
    case one = "1점 주기"
    case five = "5점 주기"
    case ten = "10점 주기"
    case reset = "점수 리셋 하기"
}


enum EmotionScore: Int {
    case reset = 0
    case one = 1
    case five = 5
    case ten = 10
}
