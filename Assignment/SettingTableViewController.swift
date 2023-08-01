//
//  SettingTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/27.
//

import UIKit

enum SettingOptions: Int, CaseIterable {
    case total, personal, others
    
    var mainOptions: String {
        switch self {
        case .total: return "전체 설정"
        case .personal: return "개인 설정"
        case .others: return "기타"
        }
    }
    
    var subOptions: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개안/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}

class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOptions

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return SettingOptions.allCases[section].subOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName.settingCell.rawValue)!
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOptions[indexPath.row]
        return cell
    }
    

}
