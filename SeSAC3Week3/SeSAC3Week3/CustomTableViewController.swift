//
//  CustomTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/28.
//

import UIKit


class CustomTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var todo = ToDoInformation() {
        didSet { // 변수가 달라짐을 감지!
            print(#function)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        searchBar.placeholder = "할 일을 입력해보세요~"
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarReturnTapped), for: .editingDidEndOnExit)
    }
    
    @objc func searchBarReturnTapped() {
        print(#function)
        // Todo 항목을 list에 추가
        // 테이블뷰 데이터 갱신
        
        let data = ToDo(main: searchBar.text!, sub: "23.12.12", like: false, done: false, color: ToDoInformation.randomBackgroundColor())
        
        // 뒤에 추가
        todo.list.append(data)
        
        // 앞에 추가
//        todo.list.insert(data, at: 0)
        searchBar.text = ""
        
//        tableView.reloadData()
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
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
//        print(#function, sender.tag)
        todo.list[sender.tag].like.toggle()
//        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    // 셀 선택
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        vc.data = todo.list[indexPath.row]
        present(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // 삭제
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 제거 -> 갱신
        todo.list.remove(at: indexPath.row)
//        tableView.reloadData()
    }
}

