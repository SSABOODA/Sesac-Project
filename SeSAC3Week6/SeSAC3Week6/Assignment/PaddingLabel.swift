//
//  PaddingLabel.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 13.0, left: 13.0, bottom: 13.0, right: 13.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
