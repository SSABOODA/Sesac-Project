//
//  SnapKitViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit
import SnapKit

// addSubView
// superView
// offset, inset
// RTL, LTR
// left, right -> 세계화? 대응

class SnapKitViewController: UIViewController {
    
    let redView = UIView()
    let purpleView = UIView()
    let blueView = UIView()
    let yellowView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        // addSubView 순서대로 View에 올라가기 때문에 layout 겹치면 안보일 수도 있으니 확인 ⭐️
        
        view.addSubview(blueView)
        view.addSubview(redView)
        view.addSubview(purpleView)
        blueView.addSubview(yellowView)
        
        redView.backgroundColor = .systemRed
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        purpleView.backgroundColor = .purple
        purpleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide) // == make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            make.verticalEdges.equalTo(view.safeAreaLayoutGuide) // == make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        blueView.backgroundColor = .systemBlue
        blueView.snp.makeConstraints {
//            make.width.height.equalTo(200) // width, height 값이 같다면 한줄 작성 가능
            $0.size.equalTo(200) // == make.width.height.equalTo(200)
            $0.center.equalTo(view) // == make.centerX.centerY.equalTo(view)
        }
        
        yellowView.backgroundColor = .systemYellow
        yellowView.snp.makeConstraints {
//            make.size.equalTo(150)
//            make.center.equalToSuperview() // equalToSuperview 내가 속한 상위 view를 기준으로 레이아웃 설정
//            make.left.top.equalToSuperview()
            
            // 상위 뷰 기준으로 완전 같게 만들겠다.
            // make.edges.equalToSuperview()
             // == make.leading.trailing.top.bottom.equalToSuperview()
             // == make.edges.equalTo(blueView)
            
            // inset, offset
//            make.edges.equalTo(blueView).offset(80)
            
//            make.top.leading.equalToSuperview().inset(30)
//            make.bottom.trailing.equalToSuperview().inset(-30)
            
//            $0.edges.equalToSuperview().inset(10)
            
//            $0.top.leading.equalToSuperview().offset(20)
//            $0.bottom.trailing.equalToSuperview().offset(10)
            
            
            
//            $0.edges.equalToSuperview().offset(50)
//            $0.top.leading.equalToSuperview().offset(50)
//            $0.bottom.trailing.equalToSuperview().offset(-50)
//            $0.top.equalToSuperview().offset(50)
//            $0.leading.equalToSuperview().offset(50)
            
            
            $0.edges.equalToSuperview().inset(50)
//            $0.edges.equalToSuperview().offset(50)
            
        }
    }
}
