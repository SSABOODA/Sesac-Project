//
//  SimilarMovie.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/19.
//

import Foundation


// MARK: - SimilarMovieData
struct SimilarMovieData: Codable {
//    let page: Int
    let results: [SimilarMovie]
//    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
//        case page
        case results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarMovie: Codable {
//    let adult: Bool
//    let backdropPath: String?
//    let genreIDS: [Int]
//    let id: Int
//    let originalLanguage, originalTitle, overview: String
//    let popularity: Double
    let posterPath: String?
//    let releaseDate: String
    let title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int

    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
        case posterPath = "poster_path"
//        case releaseDate = "release_date"
        case title
//        case video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
    
    var fullImageURL: String {
        return URL.baseImageURL + (self.posterPath ?? "")
    }
}
