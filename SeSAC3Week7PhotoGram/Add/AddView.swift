//
//  AddView.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/28.
//

import UIKit

class AddView: BaseView {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leftMargin.trailingMargin.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
    }
    
}
