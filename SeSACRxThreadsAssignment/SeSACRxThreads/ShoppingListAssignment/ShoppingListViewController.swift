//
//  ShoppingListViewController.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/5/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NextViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "\(Int.random(in: 1...100))"
    }
}

final class ShoppingListViewController: UIViewController {
    
    private let headerView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let textField = {
        let tf = UITextField()
        tf.placeholder = "무엇을 구매하실 건가요?"
        return tf
    }()
    
    private let addButton = {
        let bt = UIButton()
        bt.setTitle("추가", for: .normal)
        bt.layer.cornerRadius = 10
        bt.clipsToBounds = true
        bt.backgroundColor = .darkGray
        return bt
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.description())
        tableView.rowHeight = 80
        return tableView
    }()
    
    let viewModel = ShoppingListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bind()
    }
    
    private func bind() {
        viewModel.makeDummyData()
        
        viewModel.shoppingModel
            .bind(to: tableView.rx.items(cellIdentifier: ShoppingListTableViewCell.description(), cellType: ShoppingListTableViewCell.self)) { (row, element, cell) in
                
                cell.configureCell(element: element)
                cell.completeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.viewModel.toggleCompleteButton(row: row)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.viewModel.toggleLikeButton(row: row)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                owner.navigationController?.pushViewController(NextViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .bind(with: self) { owner, indexPath in
                owner.viewModel.data.remove(at: indexPath.row)
            }
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .bind(with: self) { owner, text in
                owner.viewModel.addQueryText.onNext(text)
                
                let result = text == "" ? owner.viewModel.data : owner.viewModel.data.filter { $0.todoContent.contains(text) }
                owner.viewModel.shoppingModel.onNext(result)
            }
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty, resultSelector: { _, text in
                return text
            })
            .bind(with: self) { owner, text in
                owner.viewModel.addToDoData(text)
            }
            .disposed(by: disposeBag)
    
    
    }
    
    private func configureHierarchy() {
        title = "쇼핑"
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(80)
        }
        
        headerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(30)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        headerView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        
    }

}
