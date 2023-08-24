//
//  Extension+UIViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present // 네비게이션 없이 present
        case presentNavigation // 네비게이션 임베드 된 preset
        case presentFullNavigation // 네비게이션 임베드 된 fullscreen presetn
        case push //
    }
    
    /*
     "고래밥" > String
     String > String.self > String.Type
     */
    
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
    
    // 'T'ype Parameter: 타입과 종류는 알려주지 않지만, 모두 같은 타입이 들어갈 것을 암시, 플레이스 홀더와 같은 역할
    // Type Constraints: 클래스 제약, 프로토콜 제약
    // 'U'pperCased
    func configureBorder<T: UIView>(view: T)  {
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
    }
    
    // Generic: 타입에 유연하게 대응하기 위한 요소
    // 코드 중복과 재사용에 대응하기가 좋아서 추상적인 표현 가능
    func sum<T: AdditiveArithmetic>(a: T, b: T) -> T {
        return a + b
    }
    
    func sumInt(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func sumDouble(a: Double, b: Double) -> Double {
        return a + b
    }
}
