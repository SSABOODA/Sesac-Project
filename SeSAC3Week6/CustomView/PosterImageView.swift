//
//  PosterImageView.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/25.
//

import UIKit

class PosterImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        print(frame.width, frame)
        backgroundColor = .yellow
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
    }
    
    // 하위뷰의 레이아웃을 잡아줌?
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews", frame.width, frame)
        layer.cornerRadius = frame.width / 2
    }
}
