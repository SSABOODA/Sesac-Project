//
//  ViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
    }
    
    deinit {
        print("deinit ViewController")
    }
    
    func bind() {
        let disposable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(10)
            .subscribe(onNext: { value in
                print(value)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                print("onDisposed")
            })
//            .disposed(by: disposeBag)
        
        disposable.dispose()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            UIApplication.shared.keyWindow?.rootViewController = nil
            self.navigationController?.pushViewController(TestViewController(), animated: true)
        }
    }
}

