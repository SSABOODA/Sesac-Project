//
//  SearchViewModel.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/6/23.
//

import Foundation
import RxSwift

final class SearchViewModel {
    var data: [AppInfo] = []
    lazy var items = BehaviorSubject(value: data)
    
    var searchQuery = BehaviorSubject(value: "")
    let disposeBag = DisposeBag()
    
    func bindAPIService() {
        searchQuery
            .subscribe(with: self) { owner, text in
                print("searchQuery: \(text)")
                BasicAPIManager.shared
                    .fetchData(query: text)
                    .asDriver(
                        onErrorJustReturn: SearchAppModel(resultCount: 0, results: [])
                    )
                    .drive(with: self) { owner, result in
//                        dump(result)
                        owner.items.onNext(result.results)
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
    
    }
}
