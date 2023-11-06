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
    
    let list = ["가사1", "가사2", "가사3", "가사4", "가사5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imageView의 경우 isUserInteractionEnabled가 default로 false로 설정되어있는데 만약 tap 활성화하려면 true를 줘야한다.
        firstImageView.isUserInteractionEnabled = true
//        print(firstImageView.isUserInteractionEnabled)
//        print(view.isUserInteractionEnabled)
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        print(list[sender.tag-1])
    }
    
    
    

    @IBAction func firstTapGesture(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
    @IBAction func secondTapGesture(_ sender: UITapGestureRecognizer) {
        print(#function)
        
        //1. 다시 앨범 못 봄
        //firstImageView.isHidden = true
        
        print("제스쳐 전", firstImageView.isHidden)
        
        //2. 조건문으로 대응
//        if firstImageView.isHidden == true {
//            firstImageView.isHidden = false
//        } else {
//            firstImageView.isHidden = true
//        }
        
        //3. not 연산자 계속 반대로 동작하기 때문에 코드가 훨씬 깔끔하게 작성됨.
//        firstImageView.isHidden = !firstImageView.isHidden
        
        //4. toggle()
//        firstImageView.isHidden.toggle()
        
        //5 삼항 연산자 대입
        firstImageView.isHidden = firstImageView.isHidden == true ? false : true
        
        print("제스쳐 후", firstImageView.isHidden)
    }
    


}

