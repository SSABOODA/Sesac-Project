//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/2/23.
//

import Foundation
import RxSwift

final class BirthdayViewModel {
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    let year = BehaviorSubject(value: 2000)
    let month = BehaviorSubject(value: 12)
    let day = BehaviorSubject(value: 20)
    let signUpButtonEnabled = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    init() {
        birthday
            .subscribe(with: self) { owner, date in
                
                print("birthday: \(date)")
                
                let component = date.makeBirthday()
                guard let year = component.year,
                      let month = component.month,
                      let day = component.day else { return }
                
                owner.year.onNext(year)
                owner.month.onNext(month)
                owner.day.onNext(day)
            }
            .disposed(by: disposeBag)
        
        year
            .subscribe(with: self) { owner, year in
                // 17세 이상 validate
                let currentComponent = Date().makeBirthday()
                guard let currentYear = currentComponent.year else { return }
                if currentYear - year >= 17 {
                    owner.signUpButtonEnabled.onNext(true)
                }
            }
            .disposed(by: disposeBag)
    }
}

