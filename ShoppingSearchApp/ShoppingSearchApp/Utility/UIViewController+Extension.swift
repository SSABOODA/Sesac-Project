//
//  UIViewController+Extension.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/08.
//

import UIKit

extension UIViewController {
    func navigationRightBarButtonItem(image: UIImage, style: UIBarButtonItem.Style, target: Any?, selector: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image,
            style: style,
            target: target,
            action: selector
        )
    }
    
    func showIndicatorView(activityIndicatorView: UIActivityIndicatorView, status: Bool) {
        if status {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
        } else {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
        }
    }
}
