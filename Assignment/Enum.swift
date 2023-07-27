//
//  Enum.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/27.
//

import Foundation

enum CellName: String {
    case settingCell = "settingCell"
}

enum SectionHeader: String {
    case allSetting = "전체 설정"
    case privateSetting = "개인 설정"
    case etcSetting = "기타"
}

enum SettingTitle: String {
    case allSetting = "allSettingList"
    case privateSetting = "privateSettingList"
    case etcSetting = "etcSettingList"
}

enum AllSettingContentTitle: String, CaseIterable {
    case notice = "공지사항"
    case laboratory = "실험실"
    case version = "버전 정보"
}

enum PrivateSettingContentTitle: String, CaseIterable {
    case individual = "개인/보안"
    case notice = "알림"
    case chat = "채팅"
    case profile = "멀티프로필"
}

enum EtcSettingContentTitle: String, CaseIterable {
    case help = "고객센터/도움말"
}
