//
//  PropertyWrapper.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/27.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T> {
    private let userDefault = UserDefaults.standard
    private let key: String
    private let defaultValue: T

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return userDefault.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            userDefault.set(newValue, forKey: key)
        }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
