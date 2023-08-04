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
        Tamagotchi(name: "방실방실 다마고치", imageName: "2-6", description: "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용~ 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니다. 방실방실"),
        Tamagotchi(name: "반짝반짝 다마고치", imageName: "3-6", description: "반짝반짝 다마고치 설명"),
    ]
    
    mutating func settingEmptyTamagochiData() {
        let emptyTamagochi = Tamagotchi(name: "준비중이에요", imageName: "noImage", description: "")
        let emptyTamagochiList = Array(repeating: emptyTamagochi, count: 50)
        self.tamagotchiList += emptyTamagochiList
    }
}
