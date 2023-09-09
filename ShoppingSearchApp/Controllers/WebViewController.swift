//
//  WebViewController.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/09.
//

import UIKit
import WebKit
import SnapKit
import RealmSwift

class WebViewController: BaseViewController, WKUIDelegate {
    
    var webView = WKWebView()
    var product: Item?
    let productTableRepository = ProductTableRepository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configureView() {
        view.addSubview(webView)
        setNavigationBar()
        loadWebView()
    }
    
    override func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func likeButtonTapped() {
        print(#function)
        guard let product else { return }
        
        print(product.isLike)
        
        if product.isLike {
            // 좋아요 상태일 경우
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: Constants.ImageName.isNotLikeImageName,
                style: .plain,
                target: self,
                action: nil
            )
            
            let data = productTableRepository.fetch().where {
                $0.productId == product.productId
            }
            
            productTableRepository.deleteItem(data.first!)
            self.product?.isLike = false
            
        } else {
            // 좋아요 상태가 아닐 경우
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: Constants.ImageName.isLikeImageName,
                style: .plain,
                target: self,
                action: nil
            )
            
            let url = URL(string: product.image)
            DispatchQueue.global().async {
                if let url = url, let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        let task = ProductTable(
                            productId: product.productId, title: product.title, image: data, mallName: product.mallName, price: product.lprice
                        )
                        self.productTableRepository.createItem(task)
                        self.productTableRepository.updateItem(
                            updateValue: [
                                "_id": task._id,
                                "isLike": false
                            ]
                        )
                    }
                }
            }
        }
        
    }
    
    func setNavigationBar() {
        guard let product else { return }
        title = product.title.removeHtmlTag()
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        // rightBarItem
        var image: UIImage?
        image = product.isLike ? Constants.ImageName.isLikeImageName : Constants.ImageName.isNotLikeImageName
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(likeButtonTapped)
        )
    }
    
    func loadWebView() {
        guard let product else { return }
        
        let link = URL.naverProductPurchaseBaseURL + "\(product.productId)"
//        let link = "https://msearch.shopping.naver.com/product/\(product.productId)"
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
