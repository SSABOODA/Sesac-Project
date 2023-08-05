//
//  SettingViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/05.
//

import UIKit

enum SettingTableViewTiTle: String, CaseIterable {
    case nameSetting = "내 이름 설정하기"
    case tamagotchi = "다마고치 변경하기"
    case resetData = "데이터 초기화"
}

enum SettingTableViewImage: String, CaseIterable {
    case nameSetting = "pencil"
    case tamagotchi = "moon.fill"
    case resetData = "arrow.clockwise"
}


class SettingViewController: UIViewController {

    @IBOutlet var settingTableView: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        title = "설정"
        
        
        backBarButtonItem()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        settingTableView.reloadData()
    }
    
    func backBarButtonItem() {
        let backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
        backBarButtonItem.tintColor = .lightGray
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingTableViewTiTle.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell")!
        cell.selectionStyle = .none
        
        cell.textLabel?.text = SettingTableViewTiTle.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(
            systemName: SettingTableViewImage.allCases[indexPath.row].rawValue
        )
        cell.imageView?.tintColor = .lightGray
        cell.detailTextLabel?.text = (indexPath.row == 0) ? userDefaults.string(forKey: "nickname") : ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if indexPath.row == 0 { // 이름 설정하기
            let vc = storyboard?.instantiateViewController(withIdentifier: NameSettingViewController.identifier) as! NameSettingViewController
            vc.modalPresentationStyle = .fullScreen
            vc.nickName = userDefaults.string(forKey: "nickname") ?? ""
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 { // 다마고치 변경하기
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        } else { // 데이터 초기화
            
        }
    }
}
