//
//  SettingTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/27.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    let settingList = [
        "allSettingList": [
            "공지사항",
            "실험실",
            "버전 정보",
        ],
        "privateSettingList": [
            "개인/보안",
            "알림",
            "채팅",
            "멀티프로필",
        ],
        "etcSettingList": [
            "고객센터/도움말",
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    

}
