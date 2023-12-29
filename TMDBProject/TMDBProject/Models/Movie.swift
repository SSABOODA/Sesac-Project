//
//  Movie.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import Foundation
import UIKit

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
        12: "Adventure",
        14: "Fantasy",
        16: "Animation",
        18: "Drama",
        27: "Horror",
        28: "Action",
        35: "Comedy",
        37: "Western",
        53: "Thriller",
        80: "Crime",
        99: "Documentary",
        878: "Science Fiction",
        9648: "Mystery",
        10402: "Music",
        10749: "Romance",
        10751: "Family",
        10752: "War",
        10759: "Action & Adventure",
        10762: "Kids",
        10763: "News",
        10764: "Reality",
        10765: "Sci-Fi & Fantasy",
        10766: "Soap",
        10767: "Talk",
        10768: "War & Politics",
        10770: "TV Movie",
    ]
    
    let id: Int
    let date: String?
    let mediaType: MediaType?
    let rate: Double
    let title: String?
    let name: String?
    let originalTitle: String?
    let description: String
    let imageURL: String?
    let genreIds: [Int]
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case date = "release_date"
        case mediaType = "media_type"
        case rate = "vote_average"
        case title
        case name
        case originalTitle = "original_title"
        case description = "overview"
        case imageURL = "backdrop_path"
        case posterPath = "poster_path"
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
        return URL.baseImageURL + (self.imageURL ?? "")
    }
    
    var fullPosterURL: String {
        return URL.baseImageURL + (self.posterPath ?? "")
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
    
    var cellIdentifier: String {
        switch self {
        case .movie:
            return TrendViewController.TrendMovieCellIdentifier
        case .tv:
            return TrendViewController.TrendTVCellIdentifier
        case .person:
            return TrendViewController.TrendPersonCellIdentifier
        }
    }
    
    var tableViewCellType: UITableViewCell {
        switch self {
        case .movie:
            return TrendMovieTableViewCell()
        case .tv:
            return TrendTVTableViewCell()
        case .person:
            return TrendPersonTableViewCell()
        }
    }
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
        return URL.baseImageURL + (self.profileImageURL ?? "")
    }
}


/*
 Search
 */


//struct MovieSearch: Decodable {
//    let page: Int
//    let results: [MovieData]
//    let totalResults: Int
//    let totalPages: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case totalResults = "total_results"
//        case totalPages = "total_pages"
//        case page
//        case results
//    }
//}
//
//struct MovieData: Decodable {
//    let id: Int
//}
