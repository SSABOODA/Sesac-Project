//
//  ViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var mainCollectionView: UICollectionView!
    
    var tamagotchi = TamagotchiInformation()
    let userDefaults = UserDefaults.standard
    var dataTransitionType: DataTransitionType = .normal
    let color = ColorData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTamagotchiData()
        configureCollectionView()
        setCollectionViewLayout()
        registerNibMainCollectionViewCell()
        designView()
    }
    
    // 준비 중(noImage)인 데이터 세팅
    func setTamagotchiData() {
        tamagotchi.settingEmptyTamagochiData()
    }
    
    // collectionView Nib 등록
    func registerNibMainCollectionViewCell() {
        mainCollectionView.register(
            UINib(nibName: MainCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
    }
}


// MARK: - CollectionView

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagotchi.tamagotchiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(tamagotchi.tamagotchiList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: PopUpViewController.identifier) as? PopUpViewController else {
            return
        }

        var row = tamagotchi.tamagotchiList[indexPath.row]
        row.rice = userDefaults.integer(forKey: "rice")
        row.water = userDefaults.integer(forKey: "water")
        row.level = userDefaults.integer(forKey: "level")
        
        vc.tamagotchi = row
        vc.dataTransitionType = dataTransitionType
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

// MARK: - MainViewController Extension


extension MainViewController {
    
    static let identifier = "MainViewController"
    
    func designView() {
        view.backgroundColor = color.backgroundColor
        mainCollectionView.backgroundColor = color.backgroundColor
    }
    
    // collectionView delegate, dataSource
    func configureCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    // main collection view layout
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 3
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width/3, height: width/3)
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        mainCollectionView.collectionViewLayout = layout
    }
}

