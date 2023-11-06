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
        static let searchBarPlaceHolder: String = "검색어를 입력해보세요"
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
    
    enum EmptyViewText {
        static let searchEmptyViewText = "상품을 검색해보세요."
        static let likeEmptyViewText = "좋아요한 상품이 없습니다."
    }
    
    enum NetworkErrorAlertText {
        static let networkingError = "잠시 후 다시 시도해주세요.😭"
        static let parseError = "검색어를 확인해주세요.✏️"
    }
    
    enum AlertText {
        static let ok = "확인"
        static let cancel = "취소"
        static let showNoQueryText = "검색어를 입력해보세요 ✏️"
        static let showCancelLikeText = "삭제하시겠습니까?"
        static let noResultQueryAlertText = "검색하신 단어의 결과가 없습니다. 😭"
        static let noInternetNetworkConnectionAlertText = "인터넷 연결을 확인해주세요 🛜"
    }
}
