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
    
    let tableView = {
       let view = UITableView()
        view.rowHeight = UITableView.automaticDimension // 1. automaticDimention
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // uinib - xib
        tableView.register(
            UITableViewCell.self, // 시스템 셀 기반으로 사용
            forCellReuseIdentifier: "customCell"
        )
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")!
        cell.textLabel?.text = list[indexPath.row].text
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isExpand.toggle()
        tableView.reloadRows(at: [indexPath], with: .right)
    }
}
