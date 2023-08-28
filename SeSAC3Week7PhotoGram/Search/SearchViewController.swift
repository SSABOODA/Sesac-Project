//
//  SearchViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // 굳이 let 상수로 customView 인스턴스 할당하는 이유
    // -> mainView 인스턴스를 통해 SearchView() 속성을 사용하기 위해
    // -> 델리게이트 패턴 활용하기 위해
    let mainView = SearchView()
    
    let imageList = [
        "pencil",
        "star",
        "person",
        "star.fill",
        "xmark",
        "person.circle",
        "info.circle",
        "globe.asia.australia",
    ]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver보다 post가 먼저 신호를 보내면...
        // 동작 X
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(recommandKeywordNotificationObserver(notification:)),
            name: NSNotification.Name("RecommandKeyword"),
            object: nil
        )
    }
    
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print(#function)
    }

    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

extension SearchViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(
            name: NSNotification.Name("SelectImage"),
            object: nil,
            userInfo: [
                "name": imageList[indexPath.item],
                "sample": "고래밥"
            ]
        )
        
        dismiss(animated: true)
    }
}
