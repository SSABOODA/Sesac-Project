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
    case series
    case season
    case video
    case similar
    case search
    
    var requestURL: String {
        switch self {
        case .trend: return URL.makeEndPointString("trending/all/week")
        case .credit: return URL.makeEndPointString("movie/")
        case .series: return URL.makeEndPointString("tv/")
        case .season: return URL.makeEndPointString("tv/")
        case .video: return URL.makeEndPointString("movie/")
        case .similar: return URL.makeEndPointString("movie/")
        case .search: return URL.makeEndPointString("search/movie")
        }
    }
}

