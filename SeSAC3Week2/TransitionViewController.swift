//
//  TransitionViewController.swift
//  SeSAC3Week2
//
//  Created by 한성봉 on 2023/07/24.
//

import UIKit

class TransitionViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //다른 화면에서 TransitionViewController로 돌아올 때(unwind) 사용하는 기능
    //액션 연결하지 않고, 직접 작성!!
    @IBAction func unwindToHome(_ seque: UIStoryboardSegue) {
    }
    
    
    
}
