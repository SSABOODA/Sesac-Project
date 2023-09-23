//
//  ReusableProtocol.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    internal static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    internal static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    internal static var reuseIdentifier: String {
        return String(describing: self)
    }
}


