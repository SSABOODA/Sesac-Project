//
//  UIViewController+Extension.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/08.
//

import UIKit

extension UIViewController {
    func showNoQueryAlert() {
        let alert = UIAlertController(title: "검색어를 입력해주세요", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
