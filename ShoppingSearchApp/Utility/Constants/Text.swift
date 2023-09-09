//
//  Text.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import Foundation

extension Constants {
    enum TextContent {
        static let searchViewNavigationTitle: String = "상품 검색"
        static let likeViewNavigationTitle: String = "좋아요 목록"
        static let searchViewTabBarTitle: String = "검색"
        static let likeViewTabBarTitle: String = "좋아요"
        static let searchBarPlaceHolder: String = "검색어를 입력해주세요"
    }
    
    enum FilterButtonTitle {
        static let accuracyFilterButtonTitle: String = "정확도"
        static let dateFilterButtonTitle: String = "날짜순"
        static let highPriceFilterButtonTitle: String = "가격높은순"
        static let lowPriceFilterButtonTitle: String = "가격낮은순"
    }
    
    enum FilterSortName {
        static let accuracy: String = "sim"
        static let date: String = "date"
        static let high: String = "dsc"
        static let low: String = "asc"
    }
}
