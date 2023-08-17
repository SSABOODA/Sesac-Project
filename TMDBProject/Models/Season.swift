//
//  Season.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/16.
//

import Foundation

// MARK: - SeasonInfo
struct SeasonInfo: Codable {
    let episodes: [Episode]
}

// MARK: - Episode
struct Episode: Codable {
    let episodeNumber: Int
    let name, overview: String
    let runtime: Int?
    let seasonNumber: Int
    let stillPath: String?
    
    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case name
        case overview
        case runtime
        case seasonNumber = "season_number"
        case stillPath = "still_path"
    }
    
    var fullImageURL: String {
        return URL.baseImageURL + (self.stillPath ?? "")
    }
}
