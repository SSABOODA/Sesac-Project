//
//  Extension+UserDefaults.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/12.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
