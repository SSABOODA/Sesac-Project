//
//  ChartViewController.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/25.
//

import UIKit

class ChartViewController: UIViewController {

    
    @IBOutlet var charView: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designCharView()

    }
    
    // MARK: - design

    func designCharView() {
        charView.forEach { item in
            item.layer.cornerRadius = 10
            item.clipsToBounds = true
        }
    }
    
    
    
    
    

}
