//
//  Enum.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/05.
//

import Foundation

enum SettingTableViewTiTle: String, CaseIterable {
    case nameSetting = "내 이름 설정하기"
    case tamagotchi = "다마고치 변경하기"
    case resetData = "데이터 초기화"
}

enum SettingTableViewImage: String, CaseIterable {
    case nameSetting = "pencil"
    case tamagotchi = "moon.fill"
    case resetData = "arrow.clockwise"
}

enum DataTransitionType {
    case normal
    case change
    case reset
}

enum StoryboardName: String {
    case main = "Main"
    case setting = "Setting"
}

