//
//  DateViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    // Protocol 값 전달 2.
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configureView() {
        super.configureView()
    }
    
    // Protocol 값 전달 3.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.receiveDate(date: mainView.picker.date)
    }
    
}
