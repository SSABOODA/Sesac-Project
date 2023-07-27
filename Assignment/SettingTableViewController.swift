//
//  SettingTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/27.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    let settingList = [
        SettingTitle.allSetting.rawValue: AllSettingContentTitle.allCases.map { $0.rawValue },
        SettingTitle.privateSetting.rawValue: PrivateSettingContentTitle.allCases.map { $0.rawValue },
        SettingTitle.etcSetting.rawValue: EtcSettingContentTitle.allCases.map { $0.rawValue }
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return SectionHeader.allSetting.rawValue
        } else if section == 1 {
            return SectionHeader.privateSetting.rawValue
        } else {
            return SectionHeader.etcSetting.rawValue
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return settingList[SettingTitle.allSetting.rawValue]!.count
        } else if section == 1 {
            return settingList[SettingTitle.privateSetting.rawValue]!.count
        } else {
            return settingList[SettingTitle.etcSetting.rawValue]!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName.settingCell.rawValue)!
        
        if indexPath.section == 0 {
            cell.textLabel?.text = settingList[SettingTitle.allSetting.rawValue]![indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = settingList[SettingTitle.privateSetting.rawValue]![indexPath.row]
        } else {
            cell.textLabel?.text = settingList[SettingTitle.etcSetting.rawValue]![indexPath.row]
        }
        return cell
    }
    

}
