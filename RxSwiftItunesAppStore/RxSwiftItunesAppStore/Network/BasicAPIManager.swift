//
//  BasicAPIManager.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/6/23.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknown
    case statusError
}

final class BasicAPIManager {
    static let shared = BasicAPIManager()
    private init() {}
    
    func fetchData(query: String) -> Observable<SearchAppModel> {
        print(#function, query)
        return Observable<SearchAppModel>.create { value in
            guard let term = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return Disposables.create() }
            let urlString = "https://itunes.apple.com/search?term=\(term)&country=KR&media=software&lang=ko_KR&limit=10"
            print("urlString: \(urlString)")
            guard let url = URL(string: urlString) else {
                value.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("URLSession Succeed")
                
                if let _ = error {
                    value.onError(APIError.unknown)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
            }.resume()
            
            return Disposables.create()
        }
    }
}

