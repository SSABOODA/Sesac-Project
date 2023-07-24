//
//  ViewController.swift
//  SeSAC3Week2
//
//  Created by 한성봉 on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imageView의 경우 isUserInteractionEnabled가 default로 false로 설정되어있는데 만약 tap 활성화하려면 true를 줘야한다.
        
        print(firstImageView.isUserInteractionEnabled)
        
        firstImageView.isUserInteractionEnabled = true
        print(firstImageView.isUserInteractionEnabled)
        print(view.isUserInteractionEnabled)
    }
    

    @IBAction func firstTapGesture(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
    @IBAction func secondTapGesture(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    


}

