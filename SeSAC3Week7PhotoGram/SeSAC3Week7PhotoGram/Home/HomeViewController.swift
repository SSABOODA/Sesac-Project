//
//  HomeViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/31.
//

import UIKit

// AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    
    let mainView = HomeView()
    
    override func loadView() {
        // 커스텀 뷰로 애써 view에 대체했는데
        // super.loadView()를 호출하면 다시 애플의 view로 대체되버리기 떄문.
        
        // delegate -> deinit 호출 안됨
        mainView.delegate = self // RC +1 ->
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        APIService.shared.callRequest(query: "moon") { photo in
            guard let photo else {
                print("Alert")
                return
            }
            print("API END")
            self.list = photo
            self.mainView.collectionView.reloadData()
        }
    }
    
    deinit {
        print(self, #function)
    }
    
}

extension HomeViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // url이 맞는지 검증해야함
        // URL(String:)
        
        let thumb = list.results[indexPath.row].urls.thumb // 네트워크 통신임.!
        let url = URL(string: thumb)
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!) // 동기 코드 -> global 큐에 넣어야함.
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
            
        }
        
//        cell.imageView.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
//        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}

extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}
