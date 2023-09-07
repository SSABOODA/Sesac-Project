//
//  ShoppingModel.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import Foundation

// MARK: - Shopping
struct Shopping: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productId: String
    let productType, brand: String
//    let maker: Maker
//    let category1: Category1
//    let category2: Category2
//    let category3: Category3
//    let category4: String
    
    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName
        case productId, productType
        case brand
//        case maker, category1, category2, category3, category4
    }
}

//enum Category1: String, Codable {
//    case 패션잡화 = "패션잡화"
//}
//
//enum Category2: String, Codable {
//    case 여행용가방소품 = "여행용가방/소품"
//}
//
//enum Category3: String, Codable {
//    case 보스턴가방 = "보스턴가방"
//}
//
//enum Maker: String, Codable {
//    case empty = ""
//    case 디피니스 = "디피니스"
//    case 보르 = "보르"
//}
