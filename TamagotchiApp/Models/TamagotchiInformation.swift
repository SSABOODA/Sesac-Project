//
//  TamagotchiInformation.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

struct TamagotchiInformation {
    var tamagotchiList: [Tamagotchi] = [
        Tamagotchi(name: "따끔따끔 다마고치", imageName: "1-6", description: "따끔따끔 다마고치 설명"),
        Tamagotchi(name: "방실방실 다마고치", imageName: "2-6", description: "방실방실 다마고치 설명"),
        Tamagotchi(name: "반짝반짝 다마고치", imageName: "3-6", description: "반짝반짝 다마고치 설명"),
    ]
    
    mutating func settingEmptyTamagochiData() {
        let emptyTamagochi = Tamagotchi(name: "준비중이에요", imageName: "noImage", description: "")
        let emptyTamagochiList = Array(repeating: emptyTamagochi, count: 50)
        self.tamagotchiList += emptyTamagochiList
    }
}
