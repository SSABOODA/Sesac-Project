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
    
    func callRequest<T: Decodable>(of: T.Type ,type: EndPoint, movieId: Int?, completionHandler: @escaping (DataResponse<T, AFError>) -> ()) {
        
        switch type {
        case .trend:
            url = type.requestURL
        case .credit:
            url = type.requestURL + "\(movieId ?? 0)" + "/credits?language=en-US"
        }
        
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
}
