//
//  ViewController.swift
//  EmotionApp
//
//  Created by 한성봉 on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {

    var happy: Int = 0
    var good: Int = 0
    var nomal: Int = 0
    var upset: Int = 0
    var depressed: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    


}

