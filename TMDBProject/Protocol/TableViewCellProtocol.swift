//
//  TableViewCellProtocol.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/09/03.
//


import UIKit

enum CustomElementType: String {
    case movie
    case tv
    case person
}

protocol CustomElementModel: AnyObject {
    var type: CustomElementType { get }
}

protocol CustomElementCell: AnyObject {
    func configure(withModel: CustomElementModel)
}
