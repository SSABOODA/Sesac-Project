//
//  SettingViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/05.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var settingTableView: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        backBarButtonItem()
        navigationTitleColor()
        navigationBarColor()
        navigationTitle()
        
        designSettingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        settingTableView.reloadData()
    }
    
    func setUpTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    func designSettingView() {
        self.view.backgroundColor = ColorData.backgroundColor
        self.settingTableView.backgroundColor = ColorData.backgroundColor
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
    
    func navigationTitle() {
        title = "설정"
    }
    
    func navigationBarColor() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = ColorData.backgroundColor
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func navigationTitleColor() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}


// MARK: - TableView Extension

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingTableViewTiTle.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell")!
        cell.selectionStyle = .none
        
        cell.textLabel?.text = SettingTableViewTiTle.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: SettingTableViewImage.allCases[indexPath.row].rawValue)
        cell.detailTextLabel?.text = (indexPath.row == 0) ? userDefaults.string(forKey: UserDefaultsKey.nickname.rawValue) : ""
        
        cell.imageView?.tintColor = .lightGray
        cell.backgroundColor = ColorData.backgroundColor
        
        cell.textLabel?.font = .boldSystemFont(ofSize: 13)
        cell.textLabel?.textColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { // 이름 설정하기
            let vc = storyboard?.instantiateViewController(withIdentifier: NameSettingViewController.identifier) as! NameSettingViewController
            vc.modalPresentationStyle = .fullScreen
            vc.nickName = userDefaults.string(forKey: "nickname") ?? ""
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 { // 다마고치 변경하기
            let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
            vc.dataTransitionType = .change
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        } else { // 데이터 초기화
            let alert = UIAlertController(
                title: "데이터 초기화",
                message: "정말 다시 처음부터 시작하실 건가요?",
                preferredStyle: .alert
            )
            let success = UIAlertAction(title: "네", style: .default) { action in
                print("확인 버튼이 눌렀습니다.")
                self.resetData()
            }
            let cancel = UIAlertAction(title: "아니요", style: .cancel) { cancel in
                print("취소 버튼이 눌렀습니다.")
            }
                
            alert.addAction(cancel)
            alert.addAction(success)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    // 데이터 초기화 시 UserDefaults 데이테 키 삭제
    func resetData() {
        let removeUserDefaultsKeyList = UserDefaultsKey.allCases.map { $0.rawValue }
        
        for index in (1...TamagotchiInformation().tamagotchiList.count) {
            userDefaults.removeObject(forKey: "\(UserDefaultsKey.imageName.rawValue)\(index)")
            userDefaults.removeObject(forKey: "\(UserDefaultsKey.name.rawValue)\(index)")
        }
        
        for key in removeUserDefaultsKeyList {
            userDefaults.removeObject(forKey: key)
        }

        userDefaults.set(false, forKey: UserDefaultsKey.isSelected.rawValue)
        changeRootScene()
    }
    
    // 데이터 초기화 후 Root Scene 교체
    func changeRootScene() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
        vc.dataTransitionType = .reset
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKey()
    }
}
