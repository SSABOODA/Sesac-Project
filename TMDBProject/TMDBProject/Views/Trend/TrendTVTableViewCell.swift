//
//  TrendTVTableViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/09/01.
//

import UIKit

class TrendTVTableViewCell: BaseTableViewCell {
    
    let dateLabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 11)
        lb.textColor = .lightGray
        return lb
    }()
    
    let hashtagLabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 13)
        lb.textColor = .black
        return lb
    }()
    
    let mainCardView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.5
        view.backgroundColor = .lightGray
        return view
    }()
    
    let mainImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 18)
        lb.textColor = .black
        lb.numberOfLines = 1
        lb.text = "Alice In Borderland"
        lb.textAlignment = .center
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(hashtagLabel)
        contentView.addSubview(mainCardView)
        mainCardView.addSubview(mainImageView)
        mainCardView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
        print(#function)
        dateLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }

        hashtagLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
        }

        mainCardView.snp.makeConstraints { make in
            make.top.equalTo(hashtagLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(400)
        }

        mainImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(mainCardView.snp.horizontalEdges).inset(15)
        }
    }
    
    func configureCell(_ rowData: Movie) {
        dateLabel.text = rowData.convertData
        hashtagLabel.text = "#\(genreIdToString(rowData.genreIds[0]))"
        if let imageURL = URL(string: rowData.fullImageURL) {
            mainImageView.kf.setImage(with: imageURL)
        }
        titleLabel.text = rowData.name
    }
    
    func genreIdToString(_ genreId: Int) -> String {
        guard let genre = Movie.genreList[genreId] else { return "" }
        return genre
    }
}

