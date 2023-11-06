//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/2/23.
//

import Foundation
import RxSwift

final class PhoneViewModel {
    let phoneNumber = BehaviorSubject(value: "010")
    let buttonEnabled = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    init() {
        phoneNumber
            .map { $0.count > 10 }
            .subscribe(with: self) { owner, value in
                owner.buttonEnabled.onNext(value)
            }
            .disposed(by: disposeBag)
    }
}
