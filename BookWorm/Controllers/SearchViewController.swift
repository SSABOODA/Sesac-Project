//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON



class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"

    @IBOutlet var collectionView: UICollectionView!
    let searchBar = UISearchBar()
    
    var movie = MovieInfo()
    
    var bookList: [Book] = []
    var searchResultList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultList = bookList
        
        navBarButtonItem()
        setupCollectionView()
        registerBookCollectionViewCell()
        setCollectionViewLayout()
        setupSearchBar()
        
        callRequset()
    }
    
    
    func callRequset(_ searchText: String = "swift") {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let text else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
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
                    self.searchResultList.append(book)
                }
                
//                print(self.bookList)
                
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
//        searchBar.placeholder = SearchBarPlaceHolder.searchViewController.rawValue
        searchBar.placeholder = "책 제목을 검색해주세요"
    }
    
    func registerBookCollectionViewCell() {
        collectionView.register(
            UINib(nibName: BookCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: BookCollectionViewCell.identifier
        )
    }
    
    func setCollectionViewLayout() {
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
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func navBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}

extension SearchViewController:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultList = bookList
        searchBar.text = ""
        collectionView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        if text.isEmpty {
            searchResultList = bookList
            collectionView.reloadData()
        } else {
            searchResult()
        }
        
    }
    
    func searchResult() {
        searchResultList.removeAll()
        let searchText = searchBar.text!
        callRequset(searchText)
        bookList = searchResultList
        
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        cell.configureCell(row: bookList[indexPath.row])
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // detailview 이동 대신 web페이지 띄우기
        guard let url = URL(string: searchResultList[indexPath.row].url), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        return
        
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifer) as? DetailViewController else { return }
////        vc.movie = searchResultList[indexPath.row]
//        vc.book = searchResultList[indexPath.row]
//        vc.type = .search
//
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        let title = searchResultList[sender.tag].title
        
        for (index, item) in bookList.enumerated() {
            if item.title == title {
                bookList[index].like.toggle()
            }
        }
        searchResultList[sender.tag].like.toggle()
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
}
