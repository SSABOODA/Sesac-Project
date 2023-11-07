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
        view.register(WeatherTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: WeatherTableViewHeaderView.headerViewID)
        view.backgroundColor = .white
        view.rowHeight = 130
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
        bindTableView()
        bindSearchBar()
        
        viewModel.bindAPIService()
    }
    
    private func bindTableView() {
        print(#function)
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                if let imageURL = URL(string: element.artworkUrl512) {
                    cell.appIconImageView.kf.setImage(with: imageURL)
                }
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        print("downloadButton tapped")
                        owner.navigationController?.pushViewController(SearchDetailViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                owner.navigationController?.pushViewController(SearchDetailViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindSearchBar() {
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty, resultSelector: { _, text in
                return text
            })
            .subscribe(with: self) { owner, text in
                print("searchButtonClicked")
                owner.viewModel.searchQuery.onNext(text)
                owner.searchBar.resignFirstResponder()
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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: WeatherTableViewHeaderView.headerViewID)
                as? WeatherTableViewHeaderView else { return UIView() }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SearchViewController {
    private func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }

    private func setNavigationBar() {
        title = "검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.titleView = searchBar
    }
}

