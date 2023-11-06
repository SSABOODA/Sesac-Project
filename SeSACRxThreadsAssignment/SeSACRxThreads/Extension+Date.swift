//
//  Extension+Date.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/1/23.
//

import Foundation

extension Date {
    func makeBirthday() -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day], from: self)
    }
}
