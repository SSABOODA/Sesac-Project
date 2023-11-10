//
//  ViewController.swift
//  RxSwiftItunesAppStore
//
//  Created by 한성봉 on 11/6/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = UIScreen.main.bounds.height * 0.38
        view.separatorStyle = .none
        return view
    }()
    
    let searchBar = UISearchBar()
    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel()
    var data: [AppInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setNavigationBar()
        bind()
    }
    
    private func bind() {
        let input = SearchViewModel.Input(
            searchButtonClicked: searchBar.rx.searchButtonClicked,
            searchTextDidBeginEditing: searchBar.rx.textDidBeginEditing,
            searchCancelButtonClicked: searchBar.rx.cancelButtonClicked,
            searchText: searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
            
                cell.configureCell(element: element)

                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        //let detailVC = SearchDetailViewController()
                        //owner.navigationController?.pushViewController(detailVC, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.modelSelected(AppInfo.self), tableView.rx.itemSelected)
            .bind(with: self) { owner, value in
                let detailVC = SearchDetailViewController()
                detailVC.appInfo = value.0
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.textDidBeginEditing
            .subscribe(with: self) { owner, _ in
                owner.searchBar.setShowsCancelButton(true, animated: true)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(with: self) { owner, _ in
                owner.searchBar.setShowsCancelButton(false, animated: true)
                owner.searchBar.resignFirstResponder()
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    private func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func setNavigationBar() {
        title = "검색"
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView = searchBar
    }
}

