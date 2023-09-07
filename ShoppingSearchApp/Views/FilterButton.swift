//
//  FilterButton.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/07.
//

import UIKit

class FilterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let edgeInsetSpacing = Constants.ButtonDesign.edgeInsetSpacing
        backgroundColor = Constants.BaseColor.background
        layer.cornerRadius = Constants.ButtonDesign.cornerRadius
        layer.borderWidth = Constants.ButtonDesign.borderWidth
        layer.borderColor = Constants.BaseColor.border
        titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.ButtonDesign.fontSize
        )
        contentEdgeInsets = UIEdgeInsets(
            top: edgeInsetSpacing,
            left: edgeInsetSpacing,
            bottom: edgeInsetSpacing,
            right: edgeInsetSpacing
        )
    }
    
}
