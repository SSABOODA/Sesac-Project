//
//  ViewController.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"
    
    @IBOutlet var mainCollectionView: UICollectionView!
    
    var tamagotchi = TamagotchiInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTamagotchiData()
        configureCollectionView()
        setCollectionViewLayout()
        registerNibMainCollectionViewCell()
        designView()
    }
    
    func setTamagotchiData() {
        tamagotchi.settingEmptyTamagochiData()
    }
    
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else {
            return
        }
        vc.tamagotchi = tamagotchi.tamagotchiList[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}


extension MainViewController {
    
    static let identifier = "MainViewController"
    
    func designView() {
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        mainCollectionView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    }
    
    // delegate, dataSource
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

