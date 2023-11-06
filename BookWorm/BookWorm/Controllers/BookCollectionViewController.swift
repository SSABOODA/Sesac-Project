//
//  BookCollectionViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

final class BookCollectionViewController: UICollectionViewController {
    
    static let identifier = "BookCollectionViewController"
    
    var movie = MovieInfo()
    var bookList = [Book]()
    var tasks: Results<BookTable>!
    let bookRepository = BookTableRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerBookCollectionViewCell()
        setCollectionViewLayout()
        setBackgroundColor()
        navigationBar()
        
        tasks = bookRepository.fetch()
        bookRepository.findFileURL()
        bookRepository.checkSchemaVersion()
        let result = bookRepository.fetch()
        print(result)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func callRequset(_ query: String = "스위프트") {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let query else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        let headers: HTTPHeaders = ["Authorization": "KakaoAK c128737a3485b11c081a3c95239f4420"]
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let data = json["documents"].arrayValue
                
                for item in data {
                    let title = item["title"].stringValue
                    let thumbnail = item["thumbnail"].stringValue
                    let url = item["url"].stringValue
                    let price = item["price"].intValue
                    let status = item["status"].stringValue
                    let desc = item["contents"].stringValue
                    let author = item["authors"][0].stringValue
                    let book = Book(
                        title: title,
                        thumbnail: thumbnail,
                        url: url,
                        price: price,
                        status: status,
                        desc: desc,
                        author: author
                    )
                    self.bookList.append(book)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - IBAction

    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as? SearchViewController else {
            return
        }
        vc.movie = movie
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen // modal 방식
        present(nav, animated: true) // modal
    }
    
    @IBAction func lookAroundBarButtonItemClicked(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: LookAroundViewController.identifier) as? LookAroundViewController else { return }
        
        let tabBarVC = UITabBarController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        
        nav.title = "Tab1"
        vc2.title = "Tab2"
        vc3.title = "Tab3"
        
        tabBarVC.setViewControllers([nav, vc2, vc3], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        
        guard let items = tabBarVC.tabBar.items else { return }
        
        items.forEach { item in
            item.image = UIImage(systemName: "star.fill")
        }
        
        present(tabBarVC, animated: true)
    }
    
    private func registerBookCollectionViewCell() {
        collectionView.register(
            UINib(nibName: BookCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: BookCollectionViewCell.identifier
        )
    }
    
    // MARK: - 구현 함수
    
    private func designNavigationBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }

    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.minimumLineSpacing = spacing // 상하
        layout.minimumInteritemSpacing = spacing // 좌우
        collectionView.collectionViewLayout = layout
    }
    
    private func navigationBar() {
        navigationController?.navigationBar.layer.addBorder([.bottom], color: .black, width: 1)
    }
    
    // MARK: - CollectionView Method
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(row: tasks[indexPath.row])
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifer) as? DetailViewController else {
            return
        }
        vc.task = tasks[indexPath.row]
        vc.type = .main
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        let task = tasks[sender.tag]
        bookRepository.updateItem(
            updateValue: [
                "_id": task._id,
                "like": task.like ? false : true
            ]
        )
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
}
