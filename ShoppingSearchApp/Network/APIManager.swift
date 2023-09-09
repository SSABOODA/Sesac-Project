//
//  APIManager.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

final class APIManager {
    static let shared = APIManager()
    private init() {}

    typealias NetworkCompletion = (Result<Shopping, NetworkError>) -> Void

    func callRequest(
        query: String,
        apiType: EndPoint,
        sort: String,
        start: Int,
        completionHandler: @escaping NetworkCompletion
    ) {
        guard let searchText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        let urlString = apiType.requestURL + searchText + "&sort=\(sort)" + "&display=\(30)" + "&start=\(start)"
        guard let url = URL(string: urlString) else { return }
        
//        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(APIKey.navaerClientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIKey.naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error)
                completionHandler(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completionHandler(.failure(.dataError))
                return
            }
            
            if let shoppingData = self.parseJSON(safeData) {
                print("Success Parse JSON")
                completionHandler(.success(shoppingData))
            } else {
                print("Failed Parse JSON")
                completionHandler(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    func parseJSON(_ shoppingData: Data) -> Shopping? {
        do {
            let shoppintData = try JSONDecoder().decode(Shopping.self, from: shoppingData)
            return shoppintData
        } catch {
            print(error)
            return nil
        }
    }
}


