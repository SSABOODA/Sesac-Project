//
//  ShoppingListViewModel.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/5/23.
//

import Foundation
import RxSwift

final class ShoppingListViewModel {
    var data = [ShoppingModel]() {
        didSet {
            shoppingModel.onNext(data)
        }
    }
    
    var shoppingModel = BehaviorSubject(value: [ShoppingModel]())
    var addQueryText = PublishSubject<String>()
    var isButtonClicked = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    init() {
        addQueryText
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func addToDoData(_ addQuery: String) {
        let newData = ShoppingModel(todoContent: addQuery)
        data.insert(newData, at: 0)
    }
    
    func toggleCompleteButton(row: Int) {
        data[row].isCompleted.toggle()
    }
    
    func toggleLikeButton(row: Int) {
        data[row].isLike.toggle()
    }
    
    func makeDummyData() {
        data.append(contentsOf: [
            ShoppingModel(
                isCompleted: false,
                todoContent: "Rx공부하기",
                isLike: true
            ),
            ShoppingModel(
                isCompleted: false,
                todoContent: "맥북 사기",
                isLike: true
            ),
            ShoppingModel(
                isCompleted: false,
                todoContent: "사이다 구매",
                isLike: true
            ),
            ShoppingModel(
                isCompleted: false,
                todoContent: "아이패드 최저가 알아보기",
                isLike: false
            ),
        ])
    }
}
