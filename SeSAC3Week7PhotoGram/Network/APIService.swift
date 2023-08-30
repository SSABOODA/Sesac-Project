//
//  APIService.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/30.
//

import Foundation

class APIService {
    static let shared = APIService() // 인스턴스 생성 방지
    
    private init() {}
    
    func callRequest() {
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
            
            let value = String(data: data!, encoding: .utf8)
            print(value)
            
//            print(response)
//            print(error)
            
        }.resume() // resume => 네트워크 통신의 시작.
    }
}

class UnsplashAPI {
    static let shared = UnsplashAPI()
    
    private init() {}
    
    func callRquest() {
        
//        https://api.unsplash.com/search/photos?query="space"&client_id=vq97_ADMU6K9nawQXv6jj8x2dAmdx6qxaDAYoqz4WYM
        
        
        
        
    }
    
    
}
