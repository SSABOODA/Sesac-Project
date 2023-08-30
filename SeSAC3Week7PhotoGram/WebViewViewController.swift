//
//  WebViewViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.youtube.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
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



