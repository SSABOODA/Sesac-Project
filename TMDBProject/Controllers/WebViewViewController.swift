//
//  WebViewViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    var youtubeKey: String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeKey)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
