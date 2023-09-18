//
//  CustomTableViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit
import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
}

class CustomTableViewController: UIViewController {
    
    // viewDidLoad보다 클로저 구문이 먼저 실행됨
    // CustomTableViewController 인스턴스 생성 직전에 클로저 구문이 우선 실행
    
    // -> 현재 클래스의 인스턴스 생성 전에 클로저가 호출되며 실행되어 버려서 self가 없는 상태이기 때문에 지연 저장 속성을 활용해서 사용해야함. ⭐️
    lazy var tableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension // 1. automaticDimention
        
        tableView.delegate = self // self => 자기 자신의 인스턴스
        tableView.dataSource = self
        // uinib - xib
        tableView.register(
            CustomTableViewCell.self, // 시스템 셀 기반으로 사용
            forCellReuseIdentifier: "customCell" // -> 스토리보드 할떄는 잘 등록했어야했는데 코드 베이스 일때는 마음대로 정하고 cellForRowAt에서만 잘 맞으면 됨
        )
        
        return tableView
    }()
    
    let imageView = {
        let view = PosterImageView(frame: .zero)
        // == CGRect(x: 0, y: 0, width: 0, height: 0)
        // == (frame: .zero)
        return view
    }()
    
//    var isExpand: Bool = false
    
    var list: [Sample] = [
        Sample(text: String(repeating: "셀 테스트1", count: 20), isExpand: false),
        Sample(text: String(repeating: "셀 테스트2", count: 10), isExpand: false),
        Sample(text: String(repeating: "셀 테스트3", count: 15), isExpand: false),
        Sample(text: String(repeating: "셀 테스트4", count: 30), isExpand: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            print("constraints")
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.label.text = list[indexPath.row].text
        cell.label.textAlignment = .center
        cell.label.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isExpand.toggle()
        tableView.reloadRows(at: [indexPath], with: .right)
    }
}
