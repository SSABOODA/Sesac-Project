//
//  SigninViewModel.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/09/12.
//

import Foundation

class SigninViewModel {
    
    var email = Observable("")
    var password = Observable("")
    var nickname = Observable("")
    var location = Observable("")
    var recommendation = Observable("")
    var isVaild = Observable(false)
    
    func checkValidation() {
        print(email.value, password.value)
        
        guard email.value.contains("@") else {
            print("Email에는 '@'가 포함되어야합니다.")
            return
        }
        
        guard email.value.count > 7 else {
            print("Email은 최소 7글자 이상이어야합니다.")
            return
        }
        
        guard password.value.count > 5 else {
            print("비밀번호는 최소 6글자 이상이어야합니다.")
            return
        }
        
        guard nickname.value.count > 1 else {
            print("닉네임은 최소 1글자 이상이어야합니다.")
            return
        }
        
        guard let _ = Int(recommendation.value) else {
            print("추천 코드는 숫자만 입력가능합니다.")
            return
        }
        
        guard recommendation.value.count > 5 else {
            print("추천 코드는 최소 6자리 이상이어야합니다.")
            return
        }
        isVaild.value = true
    }
    
    func signIn(completionHandler: @escaping () -> Void) {
        
        print("isVaild: \(isVaild)")
    }
    
}
