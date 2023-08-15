//
//  Movie.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import Foundation

// MARK: - MovieResult
struct MovieResult: Codable {
    let totalResults, totalPages, page: Int
    let movie: [Movie]

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movie = "results"
        case page
    }
}

// MARK: - MovieList
struct Movie: Codable {
    static let genreList = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
    let id: Int
    let date: String?
    let mediaType: MediaType
    let rate: Double
    let title: String?
    let description: String
    let imageURL: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case date = "release_date"
        case mediaType = "media_type"
        case rate = "vote_average"
        case title
        case description = "overview"
        case imageURL = "backdrop_path"
        case genreIds = "genre_ids"
    }

    var convertData: String {
        guard let date else {
            return "2023/12/31"
        }
        return date.split(separator: "-").reversed().joined(separator: "/")
    }
    
    var roundRate: String {
        return "\(round(self.rate*10)/10)"
    }
    
    var fullImageURL: String {
        return URL.baseImageURL + self.imageURL
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}


// MARK: - CastInfo

struct CastInfo: Codable {
    let id: Int
    let castList: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case id
        case castList = "cast"
    }
}

// MARK: - Cast
struct Cast: Codable {
    let castId: Int?
    let name: String
    let character: String?
    let profileImageURL: String?

    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case name
        case character
        case profileImageURL = "profile_path"
    }
    
    var subTitleText: String {
        return "\(character ?? "") / \"No.\(castId ?? 0)\""
    }
    
    var fullImageURL: String {
        return URL.baseImageURL + self.profileImageURL!
    }
}
