//
//  UserDefaultManager.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/27.
//

import Foundation

struct UserDefaultsManager {
    @UserDefaultWrapper(key: "happy", defaultValue: 0)
    static var happy: Int
    
    @UserDefaultWrapper(key: "good", defaultValue: 0)
    static var good: Int
    
    @UserDefaultWrapper(key: "nomal", defaultValue: 0)
    static var nomal: Int
    
    @UserDefaultWrapper(key: "upset", defaultValue: 0)
    static var upset: Int
    
    @UserDefaultWrapper(key: "depressed", defaultValue: 0)
    static var depressed: Int
}
