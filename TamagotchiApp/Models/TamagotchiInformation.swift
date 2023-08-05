//
//  TamagotchiInformation.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

struct TamagotchiInformation {
    var tamagotchiList: [Tamagotchi] = [
        Tamagotchi(name: "따끔따끔 다마고치", imageName: "1-6", description: "저는 선인장 다마고치 입니다. 키는 2cm 몸무게는 150g이에요. 성격은 소심하지만 마음은 따뜻해요. 열심히 잘 먹고 잘 클 자신은 있답니다. 반가워요 주인님."),
        Tamagotchi(name: "방실방실 다마고치", imageName: "2-6", description: "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용~ 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니다. 방실방실"),
        Tamagotchi(name: "반짝반짝 다마고치", imageName: "3-6", description: "저는 반짝반짝 빛나는 별 다마고치입니다. 키는 3000km 몸무게는 4000톤이에요. 성격은 불같지만 또 온순한 면이 있답니다. 열심히 키워주세요 반짝반짝 빛날겁니다.⭐️"),
    ]
    
    mutating func settingEmptyTamagochiData() {
        let emptyTamagochi = Tamagotchi(name: "준비중이에요", imageName: "noImage", description: "")
        let emptyTamagochiList = Array(repeating: emptyTamagochi, count: 50)
        self.tamagotchiList += emptyTamagochiList
    }
    
    
//    mutating func changeTamagotchiImageName(_ name: String) {
//        for (index, item) in tamagotchiList.enumerated() {
//            if item.name == name {
//                if let firstNum = Int(item.imageName.split(separator: "-").first!) {
//                    tamagotchiList[index].imageName = "\(firstNum)-1"
//                }
//            }
//        }
//    }
    
}
