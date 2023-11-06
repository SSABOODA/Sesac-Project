//
//  TodoTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/27.
//

import UIKit

class TodoTableViewController: UITableViewController {

    var list = [
        "장보기",
        "영화보기",
        "잠자기",
        "코드보기",
        "일기쓰기",
        "쇼핑하기",
        "게임하기",
        "술먹기",
        "책읽기",
        "드라마보기",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
        // 1. list에 내용 추가
        list.append("고래밥 먹기")
        print(list, list[list.endIndex-1])
        // 2. 이미 그려진 테이블뷰를 다시 한번 갱신 하는 코드
        
        showAlert()
        tableView.reloadData()
    }
    
    // 1. Section의 Cell의 개수를 정함
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
     
    // 2. Cell 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Identifier는 인터페이스 빌더에서 설정!
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        cell.textLabel?.configureTitleText()
        cell.detailTextLabel?.configureTitleText()
        
        cell.backgroundColor = (indexPath.row % 2 == 0) ? .lightGray : .purple
//        cell.textLabel?.text = list[indexPath.row]
//        cell.textLabel?.textColor = .black
//        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
//        cell.detailTextLabel?.text = "디테일 텍스트"
//        cell.detailTextLabel?.textColor = .blue
//        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        cell.imageView?.image = UIImage(systemName: "star.fill")
        cell.contentView.tintColor = .black
        return cell
    }

    // 3. Cell의 높이(height): 44
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}
