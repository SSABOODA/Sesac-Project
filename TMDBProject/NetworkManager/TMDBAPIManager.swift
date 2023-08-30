//
//  TMDBAPIManager.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON


class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = [
        "Authorization": "Bearer \(APIKey.tmdbAccessToken)"
    ]
    
    var url: String = ""
    
    func callRequest<T: Decodable>(
        of: T.Type,
        type: EndPoint,
        movieId: Int?,
        seriesId: Int?,
        seasonId: Int?,
        completionHandler: @escaping (T) -> ()) {
            
        url = getEndpointTypeURL(type: type, movieId: movieId, seriesId: seriesId, seasonId: seasonId)
        print(url)
            
        AF.request(
            url,
            method: .get,
            headers: header
        ).validate(statusCode: 200...500).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let err):
                print(err)
            }
        }
    }
    
//    func callRequestVideo() {
////        let url = "https://api.themoviedb.org/3/movie/872585/videos?language=en-US"
//
//        let url = getEndpointTypeURL(type: .video, movieId: 872585, seriesId: nil, seasonId: nil)
//    }
    
    func getEndpointTypeURL(
        type: EndPoint,
        movieId: Int?,
        seriesId: Int?,
        seasonId: Int?
    ) -> String {
        switch type {
        case .trend:
            return type.requestURL
        case .credit:
            return type.requestURL + "\(movieId ?? 0)" + "/credits?language=en-US"
        case .series:
            return type.requestURL + "\(seriesId ?? 110534)" + "?language=en-US"
        case .season:
            return type.requestURL + "\(seriesId ?? 110534)" + "/season" + "/\(seasonId ?? 1)" + "?language=en-US"
        case .video:
            return type.requestURL + "\(movieId ?? 0)" + "/videos?language=en-US"
        case .similar:
            return type.requestURL + "\(movieId ?? 0)" + "/similar?language=en-US"
        }
    }
}

