//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

final class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"

    @IBOutlet var collectionView: UICollectionView!
    let searchBar = UISearchBar()
    
    var movie = MovieInfo()
    var bookList: [Book] = []
    var searchResultList: [Book] = []
    
    var page: Int = 0
    var isEnd: Bool = false
    
    let bookRepository = BookTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultList = bookList
        
        navBarButtonItem()
        setupCollectionView()
        registerBookCollectionViewCell()
        setCollectionViewLayout()
        setupSearchBar()
    }
    
    
    private func callRequset(query: String, size: Int = 50, page: Int = 1) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let query else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=\(size)&page=\(page)"
        let headers: HTTPHeaders = ["Authorization": "KakaoAK c128737a3485b11c081a3c95239f4420"]
//        print(url)
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                self.isEnd = json["meta"]["is_end"].boolValue
                for item in json["documents"].arrayValue {
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
    
    private func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = SearchBarPlaceHolder.searchViewController.rawValue
    }
    
    private func registerBookCollectionViewCell() {
        collectionView.register(
            UINib(nibName: BookCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: BookCollectionViewCell.identifier
        )
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
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.prefetchDataSource = self
    }
    
    private func navBarButtonItem() {
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

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultList = bookList
        searchBar.text = ""
        collectionView.reloadData()
    }

    // 검색어가 입력될 떄 마다 request
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard let text = searchBar.text else { return }
//        if text.isEmpty {
//            searchResultList = bookList
//            collectionView.reloadData()
//        } else {
//            searchResult()
//        }
//    }
    
    private func searchResult() {
        
        searchResultList.removeAll()
        guard let text = searchBar.text else { return }
        
        callRequset(query: text)
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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y // 현재 y값
        let collectionViewContentSizeY = self.collectionView.contentSize.height // collectionView 전체 높이
        let paginationY = collectionViewContentSizeY * 0.5

        if contentOffsetY > collectionViewContentSizeY - paginationY && page < 50 && !isEnd {
            page += 1
            guard let text = searchBar.text else { return }
            callRequset(query: text)
        }
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            if bookList.count - 1 == indexPath.row && page < 50 && !isEnd {
//                page += 1
//                guard let text = searchBar.text else { return }
//                callRequset(query: text, page: page)
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
    }
    
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
        
        // create realm
        let book = searchResultList[indexPath.row]
        
        let task = BookTable(
            title: book.title,
            thumbnail: book.thumbnail,
            url: book.url,
            price: book.price,
            status: book.status,
            desc: book.desc,
            author: book.author,
            memo: ""
        )
        
        bookRepository.createItem(task)
        
        DispatchQueue.global().async {
            if let url = URL(string: book.thumbnail), let data = try? Data(contentsOf: url ) {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)!
                    self.saveImageToDocument(fileName: "book_\(task._id).jpg", image: image)
                }
            }
        }
        
        // detailview 이동 대신 web페이지 띄우기
//        guard let url = URL(string: searchResultList[indexPath.row].url), UIApplication.shared.canOpenURL(url) else { return }
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        return
        
        // DetailView 이동
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifer) as? DetailViewController else { return }
        vc.task = task
        vc.type = .search

        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
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
