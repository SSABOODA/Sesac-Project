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
//        guard let product else { return }
//        let data = productTableRepository.fetch().where {
//            $0.productId == product.productId
//        }
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped))
    }
    
    func loadWebView() {
        guard let product else { return }
        let link = "https://msearch.shopping.naver.com/product/\(product.productId)"
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
