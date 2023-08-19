//
//  YoutubeVideo.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/19.
//

import Foundation


//struct SimilarMovie {
//    var Key:String = ""
//    var Title:String = ""
//}


// MARK: - YoutubeVideo
struct YoutubeVideo: Codable {
    let id: Int
    let video: [Video]
    
    enum CodingKeys: String, CodingKey {
        case id
        case video = "results"
    }
}

// MARK: - Result
struct Video: Codable {
//    let iso639_1: ISO639_1
//    let iso3166_1: ISO3166_1
    let name, key: String
//    let site: Site
//    let size: Int
//    let type: String
//    let official: Bool
//    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
//        case iso639_1 = "iso_639_1"
//        case iso3166_1 = "iso_3166_1"
        case name, key
//        case site, size, type, official
//        case publishedAt = "published_at"
//        case id
    }
}

//enum ISO3166_1: String, Codable {
//    case us = "US"
//}
//
//enum ISO639_1: String, Codable {
//    case en = "en"
//}

enum Site: String, Codable {
    case youTube = "YouTube"
}
