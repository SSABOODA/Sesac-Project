//
//  EndPoint.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import Foundation

enum EndPoint {
    case shopping
    
    var requestURL: String {
        switch self {
        case .shopping: return URL.makeEndPointString("shop.json?query=")
        }
    }
}
