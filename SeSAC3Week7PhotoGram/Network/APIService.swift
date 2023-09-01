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
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query='\(query)'&client_id=\(APIKey.unsplashAccessKey)") else {
            return
        }
        
        // timeoutInterval: 서버 통신의 제한시간 설정
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        // CompletionHandler -> global thread에서 실행
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                // 에러 처리
                if let error {
                    print(error)
                    completionHandler(nil) // nil 던져주는거 중요 그래야 nil 받았을 정상적인 상황이 아니라는 것을 캐치하기 위해
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    print(error) // Alert 또는 Do try Catch 등
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
                // Error catch
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    print(result)
                    completionHandler(result)
                } catch {
                    print(error) // 디코딩 오류 키
                    completionHandler(nil)
                    
                }
            }
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
