//
//  APIService.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/30.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

class APIService {
    static let shared = APIService() // 인스턴스 생성 방지
    
    private init() {}
    
    func callRequest() {
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let value = String(data: data!, encoding: .utf8)
        }.resume() // resume => 네트워크 통신의 시작.
    }
}

class UnsplashAPI {
    static let shared = UnsplashAPI()
    
    private init() {}
    
    typealias NetworkCompletion = (Result<Unsplash, NetworkError>) -> Void
    
    func callRquest(query: String, perPage: Int, completionHandler: @escaping NetworkCompletion) {
        
        let urlString = "https://api.unsplash.com/search/photos?per_page=\(perPage)&query='\(query)'&client_id=\(APIKey.unsplashAccessKey)"
    
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription)
                completionHandler(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completionHandler(.failure(.dataError))
                return
            }
            
            if let unsplash = self.parseJSON(safeData) {
                print("Success Parse JSON")
                completionHandler(.success(unsplash))
            } else {
                print("Failed Parse JSON")
                completionHandler(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    func parseJSON(_ unsplashData: Data) -> Unsplash? {
        do {
            let unsplashData = try JSONDecoder().decode(Unsplash.self, from: unsplashData)
            return unsplashData
        } catch {
            print(error)
            return nil
        }
    }
}
