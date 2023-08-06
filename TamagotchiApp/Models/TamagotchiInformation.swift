//
//  TamagotchiInformation.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

struct TamagotchiInformation {
    var tamagotchiList: [Tamagotchi] = [
        Tamagotchi(name: "따끔따끔 다마고치", imageName: "1-6", description: "저는 선인장 🌵 다마고치입니다. 키는 2cm 몸무게는 150g 이에요. 성격은 소심하지만 마음은 따뜻해요. 열심히 잘 먹고 잘 클 자신은 있답니다. 반가워요 주인님~:)"),
        Tamagotchi(name: "방실방실 다마고치", imageName: "2-6", description: "저는 방실방실 ☀️ 다마고치입니당! 키는 100km 몸무게는 150톤이에용! 성격은 화끈하고 날라다닙니당! 열심히 잘 먹고 잘 클 자신은 있답니당! 방실방실!"),
        Tamagotchi(name: "반짝반짝 다마고치", imageName: "3-6", description: "저는 반짝반짝 ⭐️ 다마고치에요~ 키는 120cm 몸무게는 120g이에요~ 성격도 반짝반짝 시원시원 해요~ 저를 키워주세요~ 잘 먹고 잘 커볼게요~"),
    ]

    // 준비중이에요 데이터 세팅
    mutating func settingEmptyTamagochiData() {
        let emptyTamagochi = Tamagotchi(name: "준비중이에요", imageName: "noImage", description: "")
        let emptyTamagochiList = Array(repeating: emptyTamagochi, count: 50)
        self.tamagotchiList += emptyTamagochiList
    }
    
    func randomTamagotchiSpeechContent() -> String {
        
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? ProfileInfo().userProfile.nickName
        
        var tamagotchiSpeechList: [String] = [
            "레벨업 했어여~~~",
            "감사합니다.",
            "열심히 해보자구요",
            "오늘 날씨가 너무 덥네요",
            "iOS는 재밌는거 같아요! 그렇죠?",
            "이번 과제 힘들죠? 좀만 힘내요ㅎ",
            "무럭무럭 크고 있는거 같아요",
            "\(nickname)님 오늘 과제하셨어요?",
            "\(nickname)님 오늘 기분은 어때요?",
            "건강 조심하세요 \(nickname)님",
        ]
        return tamagotchiSpeechList.randomElement()!
    }
    
//    func updateNickname() {
//        TamagotchiInformation.nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? ProfileInfo().userProfile.nickName
//    }
    
    
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
