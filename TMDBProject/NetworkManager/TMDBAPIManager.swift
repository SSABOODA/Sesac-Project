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
        completionHandler: @escaping (DataResponse<T, AFError>) -> ()) {
            
        url = getEndpointTypeURL(type: type, movieId: movieId, seriesId: 110534, seasonId: 1)
        
        AF.request(
            url,
            method: .get,
            headers: header
        ).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success:
                completionHandler(response)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getEndpointTypeURL(type: EndPoint, movieId: Int?, seriesId: Int, seasonId: Int) -> String {
        switch type {
        case .trend:
            return type.requestURL
        case .credit:
            return type.requestURL + "\(movieId ?? 0)" + "/credits?language=en-US"
        case .series:
            return type.requestURL + "\(110534)" + "?language=en-US"
        case .season:
            return type.requestURL + "\(110534)" + "/season" + "\(1)" + "?language=en-US'"
        }
    }
}
