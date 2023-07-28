//
//  CustomTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/28.
//

import UIKit


class CustomTableViewController: UITableViewController {
    
    let todo = ToDoInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // withIdentifier: CustomTableViewCell 클래스의 타입 속성으로 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        let row = todo.list[indexPath.row]
        
        // Controller에 있던 UI 코드들 Cell로 뺴기
        cell.configureCell(row: row)
        
        return cell
    }
    
    // 셀 선택
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

