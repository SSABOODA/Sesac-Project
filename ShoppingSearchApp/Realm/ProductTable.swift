//
//  ProductModel.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/08.
//

import Foundation
import RealmSwift

class ProductTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var productId: String
    @Persisted var title: String
    @Persisted var image: Data?
    @Persisted var mallName: String
    @Persisted var price: String
    @Persisted var isLike: Bool
    
    convenience init(
        productId: String,
        title: String,
        image: Data?,
        mallName: String,
        price: String
    ) {
        self.init()
        self.productId = productId
        self.title = title
        self.image = image
        self.mallName = mallName
        self.price = price
        self.isLike = false
    }
}
