//
//  TestViewController.swift
//  LEDBoard
//
//  Created by 한성봉 on 2023/07/24.
//

import UIKit
import MarqueeLabel

class TestViewController: UIViewController {

    @IBOutlet var marqueeLabel: MarqueeLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marqueeLabel.text = "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
        
        marqueeLabel.speed = .duration(20) //느림
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
