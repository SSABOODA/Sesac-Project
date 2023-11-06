//
//  SerachViewController.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/5/23.
//

import UIKit
import RxSwift
import RxCocoa

class SampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "\(Int.random(in: 1...100))"
    }
}

final class SearchViewController: UIViewController {
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 80
        view.separatorStyle = .none
        return view
    }()
    
    let searchBar = UISearchBar()
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        configure()
        bind()
        setSearchController()
    }
    
    private func bind() {
        // cellForRowAt
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element
                cell.appIconImageView.backgroundColor = .green
                cell.downloadButton.rx.tap
                    .bind(with: self) { owner, void in
                        owner.navigationController?.pushViewController(SampleViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // didSelectRowAt
        Observable.zip(
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(String.self)
        )
            .map { "셀 선택 \($0) \($1)"}
            .bind(to: searchBar.rx.text)
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty) { void, text in
                return text
            }
            .subscribe(with: self) { owner, text in
                print("searchButtonClicked, \(text)")
                owner.viewModel.addDataWhenSearchButtonClicked(query: text)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // 1초 딜레이
            .distinctUntilChanged() // 설정한 시간이 가기전 같은 단어는 무시한다.
            .subscribe(with: self) { owner, value in
                owner.viewModel.filterDataWhenInputSearchBarText(query: value)
            }
            .disposed(by: disposeBag)
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
