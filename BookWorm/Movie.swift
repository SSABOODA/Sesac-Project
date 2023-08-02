//
//  Movie.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit

struct Movie {
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
    var like: Bool
    var color: UIColor
    
    var runtimeText: String {
        return "\(self.runtime)분"
    }
    
    var rateText: String {
        return "평균 ★\(self.rate)"
    }
    
}
