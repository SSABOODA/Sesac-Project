//
//  SearchViewModel.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/6/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}

final class SearchViewModel: ViewModelType {
    struct Input {
        let searchButtonClicked: ControlEvent<Void>
        let searchTextDidBeginEditing: ControlEvent<Void>
        let searchCancelButtonClicked: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        var items: BehaviorSubject<[AppInfo]>
    }
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        lazy var items = BehaviorSubject(value: [AppInfo]())
        
        input.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText, resultSelector: { _, query in
                return query
            })
            .flatMap {
                BasicAPIManager.shared.fetchData(query: $0)
            }
            .subscribe(with: self, onNext: { owner, value in
                items.onNext(value.results)
            })
            .disposed(by: disposeBag)
        
        return Output(
            items: items
        )
    }
    
}
