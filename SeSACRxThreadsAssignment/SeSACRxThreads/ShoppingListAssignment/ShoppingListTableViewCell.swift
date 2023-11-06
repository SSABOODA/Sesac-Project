//
//  ShoppingListTableViewCell.swift
//  SeSACRxThreads
//
//  Created by 한성봉 on 11/5/23.
//

import UIKit
import RxSwift

final class ShoppingListTableViewCell: UITableViewCell {
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    let completeButton = {
        let bt = UIButton()
        return bt
    }()
    
    let todoContentLabel = {
        let lb = UILabel()
        return lb
    }()
    
    let likeButton = {
        let bt = UIButton()
        return bt
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureHierarchy()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(element: ShoppingModel) {
        todoContentLabel.text = element.todoContent
        completeButton.setImage(element.isCompleted ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        likeButton.setImage(element.isLike ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
    }
    
    private func configureHierarchy() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        backView.addSubview(completeButton)
        completeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        backView.addSubview(todoContentLabel)
        todoContentLabel.snp.makeConstraints { make in
            make.leading.equalTo(completeButton.snp.trailing).offset(20)
            make.verticalEdges.equalTo(completeButton.snp.verticalEdges)
        }
        
        backView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.verticalEdges.equalTo(completeButton.snp.verticalEdges)
        }
    }
}


