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
        query: String? = "",
        completionHandler: @escaping (T) -> ()) {
            
        url = getEndpointTypeURL(
            type: type,
            movieId: movieId,
            seriesId: seriesId,
            seasonId: seasonId,
            query: query
        )
            
        print("url: \(url)")
            
        AF.request(
            url,
            method: .get,
            headers: header
        ).validate(statusCode: 200...500).responseDecodable(of: T.self) { response in
//            print("response: \(response)")
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getEndpointTypeURL(
        type: EndPoint,
        movieId: Int?,
        seriesId: Int?,
        seasonId: Int?,
        query: String?
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
        case .search:
            guard let query else { return "" }
            let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return type.requestURL + "?query=\(text ?? "")"
        }
    }
}

