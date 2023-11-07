//
//  SearchViewModel.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/6/23.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}

final class SearchViewModel: ViewModelType {
    struct Input {
            let inputMessage: Observable<String>
        }
        
    struct Output {
        let outputMessage: Observable<String>
    }
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let a = Observable.of("")
        return Output(
            outputMessage: a
        )
    }
    
    var data: [AppInfo] = []
    lazy var items = BehaviorSubject(value: data)
    
    var searchQuery = BehaviorSubject(value: "")
    
    func bindAPIService() {
        searchQuery
            .flatMap {
                BasicAPIManager.shared.fetchData(query: $0)
            }
            .subscribe(with: self) { owner, data in
                dump(data)
                owner.items.onNext(data.results)
            }
            .disposed(by: disposeBag)
    }
}
