//
//  SearchViewModel.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/5/23.
//

import Foundation
import RxSwift

final class SearchViewModel {
    var data = ["A", "B", "C", "D"]
    var items = BehaviorSubject(value: Array(100...150).map { "안녕하세요 \($0)"})
    let disposeBag = DisposeBag()
    
    func addDataWhenSearchButtonClicked(query: String) {
        print(query)
        data.insert(query, at: 0)
        items.onNext(data)
    }
    
    func filterDataWhenInputSearchBarText(query: String) {
        let result = query == "" ? data : data.filter { $0.contains(query) }
        items.on(.next(result))
    }
}
