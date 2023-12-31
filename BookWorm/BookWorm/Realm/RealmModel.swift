//
//  RealmModel.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var thumbnail: String
    @Persisted var url: String?
    @Persisted var price: Int
    @Persisted var status: String
    @Persisted var desc: String?
    @Persisted var author: String?
    @Persisted var like: Bool
    @Persisted var etc: String?
    @Persisted var date: Date
    @Persisted var customTitle: String
    
    convenience init(
        title: String,
        thumbnail: String,
        url: String?,
        price: Int,
        status: String,
        desc: String?,
        author: String?,
        memo: String?
    ) {
        self.init()
        self.title = title
        self.thumbnail = thumbnail
        self.url = url
        self.price = price
        self.status = status
        self.desc = desc
        self.author = author
        self.like = false
        self.etc = memo
        self.date = Date()
        self.customTitle = "작가 이름은 \(author ?? "미정")이고 책 이름은 \(title)이다."
    }
}





//Book(
//    title: title,
//    thumbnail: thumbnail,
//    url: url,
//    price: price,
//    status: status,
//    desc: desc,
//    author: author
//)
