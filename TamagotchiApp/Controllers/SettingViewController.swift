//
//  SettingViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/05.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var settingTableView: UITableView!
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as? SettingTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureCell(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: moveToChangeNameView() // 이름 설정하기
        case 1: moveToSelectTamagotchi() // 다마고치 변경하기
        case 2: dataInitializeAlert() // 데이터 초기화
        default: return
        }
    }
    
    
    // 데이터 초기화 시 UserDefaults 데이테 키 삭제
    func resetData() {
        UserDefaults.resetDefaults()
        changeRootScene()
    }
    
    // 데이터 초기화 후 Root Scene 교체
    func changeRootScene() {
        UserDefaultsHelper.shared.isSelected = false
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
        vc.dataTransitionType = .reset
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKey()
    }
    
    
    func moveToChangeNameView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: NameSettingViewController.identifier) as? NameSettingViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.nickName = UserDefaultsHelper.shared.nickname
        navigationController?.pushViewController(vc, animated: true)
    }
    func moveToSelectTamagotchi() {
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController else { return }
        vc.dataTransitionType = .change
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    func dataInitializeAlert() {
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
