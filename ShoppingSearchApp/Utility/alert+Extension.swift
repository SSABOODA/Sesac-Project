//
//  alert+Extension.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/11.
//

import UIKit

extension UIViewController {
    // 빈 문자열 입력시 Alert
    func showNoQueryAlert() {
        let alert = UIAlertController(title: "검색어를 입력해주세요", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 좋아요 취소 Alert
    func showCancelLikeAlert(completionHandler: @escaping () -> ()) {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 네트워킹 Network Error alert
    func showNetworkingErrorAlert(title: String, completionHandler: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
