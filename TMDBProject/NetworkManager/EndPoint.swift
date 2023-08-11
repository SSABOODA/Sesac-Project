//
//  EndPoint.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import Foundation

enum EndPoint {
    case trend
    case credit
    
    var requestURL: String {
        switch self {
        case .trend: return URL.makeEndPointString("trending/all/week")
        case .credit: return URL.makeEndPointString("movie/")
        }
    }
}

