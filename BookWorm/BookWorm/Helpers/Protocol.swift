//
//  Protocol.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/08/03.
//

import Foundation

@objc protocol TableViewCellProtocol {
    func designCommonCell()
    @objc optional func configureCell()
}


@objc protocol CollectionViewCellProtocol {
    func designCommonCell()
    @objc optional func configureCell()
}
