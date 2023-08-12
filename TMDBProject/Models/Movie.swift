//
//  Movie.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import Foundation


struct Movie {
    var date: String
    var mediaType: String
    var rate: Double
    var title: String
    var description: String
    var imageURL: String
    
    var convertData: String {
        return date.split(separator: "-").reversed().joined(separator: "/")
    }
    
    var roundRate: String {
        return "\(round(self.rate*10)/10)"
    }
    
}
