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
    
    func callRequest(type: EndPoint, movieId: Int?, completionHandler: @escaping (JSON) -> ()) {
        
        if let movieId {
            url = type.requestURL + "\(movieId)" + "/credits?language=en-US"
        } else {
            url = type.requestURL
        }
        
        AF.request(
            url,
            method: .get,
            headers: header
        ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
