//
//  DetailViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"

    var data: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = data else { return }
        print(data)
        
    }
    
    
    

}
