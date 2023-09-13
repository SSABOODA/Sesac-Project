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
        let alert = UIAlertController(
            title: Constants.AlertText.showNoQueryText,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: Constants.AlertText.ok,
            style: .default
        )
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 네트워크 결과 없을 경우 alert
    func noResultQueryAlert() {
        let alert = UIAlertController(
            title: Constants.AlertText.noResultQueryAlertText,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: Constants.AlertText.ok,
            style: .default
        )
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 좋아요 취소 Alert
    func showCancelLikeAlert(completionHandler: @escaping () -> ()) {
        let alert = UIAlertController(
            title: Constants.AlertText.showCancelLikeText,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: Constants.AlertText.ok,
            style: .default) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(
            title: Constants.AlertText.cancel,
            style: .destructive
        )
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 네트워킹 Network Error alert
    func showNetworkingErrorAlert(title: String, completionHandler: @escaping () -> ()) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: Constants.AlertText.ok,
            style: .default) { _ in
            completionHandler()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 인터넷 연결이 안되어 있을 경우 alert
    func showAlertIfNoInternetNetworkConnection() {
        let alert = UIAlertController(
            title: Constants.AlertText.noInternetNetworkConnectionAlertText,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: Constants.AlertText.ok,
            style: .default
        )
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
