//
//  Tamagotchi.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit


struct Tamagotchi {
    var name: String
    var imageName: String
    var description: String
    var level: Int = 1
    var rice: Int = 0
    var water: Int = 0
    
    var currentLevelText: String {
        return "LV\(level) · 밥알 \(rice)개 · 물방울 \(water)개"
    }
}
