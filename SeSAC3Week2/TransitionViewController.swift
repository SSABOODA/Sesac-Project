//
//  TransitionViewController.swift
//  SeSAC3Week2
//
//  Created by 한성봉 on 2023/07/24.
//

import UIKit
import Kingfisher

class TransitionViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var actorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 100M라면?....
        setImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrCa0fKRwgS8a5_2ftkdYuuRdRIpzxC8AFxQ&usqp=CAU")
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        // http(apple -> block) vs https
        // App Transport Security Setting
        var urlString: String = ""
        if sender.selectedSegmentIndex == Actor.man.rawValue {
            urlString = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrCa0fKRwgS8a5_2ftkdYuuRdRIpzxC8AFxQ&usqp=CAU"
        } else if sender.selectedSegmentIndex == Actor.woman.rawValue {
            urlString = "https://i.namu.wiki/i/vjSWu_Vv0e0C8FxY5v1WpXyRuPMMQ9IYAiaighmGyJE7vyy6zx-1i3NT5_OvtEp9m_19TznbOe6bMB3CyAOBLw.webp"
        } else {
            urlString = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrCa0fKRwgS8a5_2ftkdYuuRdRIpzxC8AFxQ&usqp=CAU"
        }
        
        setImage(urlString)
    }
    
    func setImage(_ url: String) {
        let url = URL(string: url)
        actorImageView.kf.setImage(with: url)
    }
    
    
    
    //다른 화면에서 TransitionViewController로 돌아올 때(unwind) 사용하는 기능
    //액션 연결하지 않고, 직접 작성!!
    @IBAction func unwindToHome(_ seque: UIStoryboardSegue) {
    }
    
    
    
}
