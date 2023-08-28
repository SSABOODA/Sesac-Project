//
//  ViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {

    let mainView = AddView()
    
    // viewDidLoad보다 먼저 호출됨
    // super 메서드 호출 X ⭐️
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver),
            name: NSNotification.Name("SelectImage"),
            object: nil
        )
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print(#function)
        
        print(notification.userInfo?["sample"] as! String)
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        
        let word = ["Apple", "Banana", "Cookie", "Caek", "Sky"]
        
        NotificationCenter.default.post(
            name: Notification.Name("RecommandKeyword"),
            object: nil,
            userInfo: [
                "word": word.randomElement()!
            ]
        )
        present(SearchViewController(), animated: true)
    }
    
    override func configureView() {
        super.configureView()
        print("Add ConfigureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        print("Add SetConstraints")
        
    }
}

