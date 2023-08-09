//
//  Enum.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import Foundation

enum TransitionType {
    case main
    case around
    case search
}

enum StoryboardName: String {
    case main = "Main"
}

enum SearchBarPlaceHolder: String {
    case searchViewController = "책 제목을 검색해주세요"
    case detailViewController = "아무거나 입력해주세요~~"
}

enum TableViewTitleForHeader: String {
    case lookAroundViewController = "요즘 인기 작품"
}
