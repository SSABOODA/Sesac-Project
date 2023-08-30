//
//  WebViewViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
//    var webView: WKWebView!
    var webView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(50)
        }
        
        
        let myURL = URL(string:"https://www.youtube.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
        // 네비게이션 컨트롤러가 처음에는 투명, 스크롤 하면 불투명
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        
        // 투명도
        navigationController?.navigationBar.isTranslucent = false
        // scrollEdgeAppearance: 시작부터 적용 -> 스크롤하면 없어짐
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        title = "이건 웹뷰입니다."
    }
    
    
    
    
    
    
    
    func reloadButtonClicked() {
        webView.reload() // 리로드 버튼
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    
    
}



