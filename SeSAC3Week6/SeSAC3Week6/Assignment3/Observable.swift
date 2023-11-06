//
//  Oservable.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/09/12.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
