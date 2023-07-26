//
//  EmotionEnum.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/25.
//

import Foundation


enum Emotion: Int, CaseIterable {
    case happy, good, nomal, upset, depressed
    
    // enum case string return
    var str: String {
        String(describing: self)
    }
}
