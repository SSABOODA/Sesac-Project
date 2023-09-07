//
//  URL+Extension.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import Foundation

extension URL {
    static let baseURL = "https://openapi.naver.com/v1/search/"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
}
