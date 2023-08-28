//
//  Extension+UIViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit

extension UIViewController {
    enum TransitionStyle {
        case present // 네비게이션 없이 present
        case presentNavigation // 네비게이션 임베드 된 preset
        case presentFullNavigation // 네비게이션 임베드 된 fullscreen present
        case push //
    }
    func transition<T: UIViewController>(viewController: T.Type, storyboard: String, style: TransitionStyle) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else { return }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
