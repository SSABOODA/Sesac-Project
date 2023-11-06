//
//  StudyTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/27.
//

import UIKit

class StudyTableViewController: UITableViewController {
    
    let studyList = [
        "변수",
        "상수",
        "열거형",
        "클래스",
        "구조체",
        "오토레이아웃",
        "메서드",
        "프로퍼티",
        "옵셔널 바인딩",
        "테이블뷰",
    ]
    
    let appleList = [
        "아이폰",
        "애플워치",
        "맥북",
        "에어팟",
        "아이패드"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // heightForRowAt 메서드에서 조건에 따라 높이를 줄 것이 아니라면 호출 비효율이 일어나기 떄문에 한번에 동일한 셀의 높이를 지정해주는 속성
        tableView.rowHeight = 60
    }
    
    // 0. 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return section == 0 ? "첫번째 섹션" : "두번쨰 섹션"
        
        // 100% 모든 경우의 수를 return 해주어야 합니다.!
        if section == 0 {
            return "1"
        } else if section == 1 {
            return "2"
        } else if section == 2 {
            return "3"
        } else {
            return ""
        }
        
    }
    
    // 1. 셀 개수(필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? studyList.count : appleList.count
    }
    
    // 2. cell 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // identifier에 맞는 셀이 있을 수 있기 때문에 옵셔널로 반환을 해줌 > 해제가 필요!
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        cell.textLabel?.text = indexPath.section == 0 ? studyList[indexPath.row] : appleList[indexPath.row]
        
        // textLabel이 옵셔널인 이유?
        // 시스템 셀을 보면
        // title이 있을수도 있고 없을수도 있고
        // detailTextLabel도 있을 수도 있고 없을수도 있고
        return cell
    }
    
    // 3. 셀 높이: 서비스 구현에 따라 필요한 경우가 많지만, 항상 같은 높이를 셀에서 사용한다면 비효율적일 수 있음.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 50 : 100
    }
}
