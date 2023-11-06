//
//  Extension+URL.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import Foundation

// https://api.themoviedb.org/3/trending/all/{time_window}
// https://api.themoviedb.org/3/trending/movie/{time_window}
// https://api.themoviedb.org/3/trending/person/{time_window}
// https://api.themoviedb.org/3/trending/tv/{time_window}

// https://api.themoviedb.org/3/movie/{movie_id}/credits

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
}
