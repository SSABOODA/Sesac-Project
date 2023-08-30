//
//  ViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit
import SeSACFramework

// protocol 값 전달 1.
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDelegate {
    func receiveImage(image: UIImage)
}

class AddViewController: BaseViewController {

    let mainView = AddView()
    
    // viewDidLoad보다 먼저 호출됨
    // super 메서드 호출 X ⭐️
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClassOpenExample.publicExample()
        ClassPublicExample.publicExample()
//        ClassInternalExample.internalExample() // 접근 불가능
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver),
            name: .selectImage,
            object: nil
        )
        
//        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: .selectImage,
            object: nil
        )
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print(#function)
        
//        print(notification.userInfo?["name"] as! String)
//        print(notification.userInfo?["sample"] as! String)
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        
        let word = ["Apple", "Banana", "Cookie", "Caek", "Sky"]
        
        // post 신호가 먼저 가고
        // 다음 뷰컨이 생성되어서 값 전달이 안될 수도 있다.
        // addObserver보다 post가 먼저 신호를 보내면 안됨
        NotificationCenter.default.post(
            name: Notification.Name("RecommandKeyword"),
            object: nil,
            userInfo: [
                "word": word.randomElement()!
            ]
        )
        navigationController?.pushViewController(SearchViewController(), animated: true)
//        present(SearchViewController(), animated: true)
    }
    
    @objc func dateButtonClicked() {
        print(#function)
        //protocol 값 전달 5.
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        //protocol 값 전달 5.
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        
        // Closure - 3
        vc.completionHandler = { title, age, push in
            print("CompletionHandler")
            print(title, age, push)
//            self.mainView.titleButton.setTitle(data, for: .normal)
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func contentButtonClicked() {
        let vc = ContentViewController()
        vc.completionHandler = { data in
            self.mainView.contentButton.setTitle(data, for: .normal)
            print("CompletionHandler")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        print("Add ConfigureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.contentButton.addTarget(self, action: #selector(contentButtonClicked), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        print("Add SetConstraints")
    }
}

// protocol 값 전달 4.
extension AddViewController: PassDataDelegate {
    func receiveDate(date: Date) {
        let date = DateFormatter.convertDate(date: date)
        mainView.dateButton.setTitle("\(date)", for: .normal)
    }
}

extension AddViewController: PassImageDelegate {
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}
