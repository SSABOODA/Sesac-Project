//
//  UserDefaultsHelper.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/12.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    private init() { }
    
    let ud = UserDefaults.standard
    
    enum Key: String {
        case index
        case water
        case rice
        case level
        case nickname
        case imageName
        case name
        case isSelected
    }
    
    var index: Int {
        get {
            return ud.integer(forKey: Key.index.rawValue)
        }
        set {
            ud.set(newValue, forKey: Key.index.rawValue)
        }
    }
    
    var water: Int {
        get {
            return ud.integer(forKey: Key.water.rawValue)
        }
        set {
            ud.set(newValue, forKey: Key.water.rawValue)
        }
    }
    
    var rice: Int {
        get {
            return ud.integer(forKey: Key.rice.rawValue)
        }
        set {
            ud.set(newValue, forKey: Key.rice.rawValue)
        }
    }
    
    var level: Int {
        get {
            return ud.integer(forKey: Key.level.rawValue)
        }
        set {
            ud.set(newValue, forKey: Key.level.rawValue)
        }
    }

    var nickname: String {
        get {
            return ud.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            ud.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var imageName: String {
        get {
            return ud.string(forKey: Key.imageName.rawValue) ?? ""
        }
        set {
            ud.set(newValue, forKey: Key.imageName.rawValue)
        }
    }
    
    var name: String {
        get {
            return ud.string(forKey: Key.name.rawValue) ?? ""
        }
        set {
            ud.set(newValue, forKey: Key.name.rawValue)
        }
    }
    
    var isSelected: Bool {
        get {
            return ud.bool(forKey: Key.isSelected.rawValue)
        }
        set {
            ud.set(newValue, forKey: Key.isSelected.rawValue)
        }
    }
    
    
    
}
