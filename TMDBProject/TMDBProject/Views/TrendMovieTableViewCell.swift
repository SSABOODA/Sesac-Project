//
//  TrendMovieTableViewCell.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/09/01.
//

import UIKit

class TrendMovieTableViewCell: BaseTableViewCell {

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
    
    let clipButton = {
        let bnt = UIButton()
        bnt.setImage(UIImage(systemName: "paperclip"), for: .normal)
        bnt.setTitleColor(UIColor.black, for: .normal)
        bnt.backgroundColor = .white
        bnt.layer.cornerRadius = bnt.frame.width / 2
        bnt.clipsToBounds = true
        bnt.tintColor = .black
        return bnt
    }()
    
    let rateView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let rateTitleLabel = {
        let lb = UILabel()
        lb.text = "평점"
        lb.font = .boldSystemFont(ofSize: 10)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .systemBlue
        return lb
    }()
    
    let rateLabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 10)
        lb.backgroundColor = .white
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    let titleLabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 18)
        lb.textColor = .black
        lb.numberOfLines = 1
        lb.text = "Alice In Borderland"
        return lb
    }()
    
    let subTitleLabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 13)
        lb.textColor = .lightGray
        lb.numberOfLines = 1
        lb.text = "Alice In Borderland,, Borderland, Borderland,"
        return lb
    }()
    
    let lineView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let lookDetailTitle = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15)
        lb.textColor = .black
        lb.text = "자세히 보기"
        return lb
    }()
    
    let lookDetailButton = {
        let bnt = UIButton()
        bnt.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        bnt.tintColor = .black
        return bnt
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipButton.layer.cornerRadius = clipButton.frame.width / 2
    }
    
    override func configureView() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(hashtagLabel)
        contentView.addSubview(mainCardView)
        
        mainCardView.addSubview(mainImageView)
        mainCardView.addSubview(clipButton)

        mainImageView.addSubview(rateView)
        rateView.addSubview(rateTitleLabel)
        rateView.addSubview(rateLabel)
        
        mainCardView.addSubview(titleLabel)
        mainCardView.addSubview(subTitleLabel)
        mainCardView.addSubview(lineView)
        mainCardView.addSubview(lookDetailTitle)
        mainCardView.addSubview(lookDetailButton)
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
        
        clipButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
            make.size.equalTo(25)
        }

        rateView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(20)
            make.width.equalTo(50)
            make.height.equalTo(25)
        }

        rateTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(rateView).inset(2)
            make.width.equalTo(23)
        }

        rateLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(rateView).inset(2)
            make.width.equalTo(23)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(mainCardView.snp.horizontalEdges).inset(15)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(mainCardView.snp.horizontalEdges).inset(15)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(mainCardView.snp.horizontalEdges).inset(15)
            make.height.equalTo(1)
        }

        lookDetailTitle.snp.makeConstraints { make in
            make.bottom.equalTo(mainCardView.snp.bottom).offset(-15)
            make.leading.equalToSuperview().offset(15)
        }

        lookDetailButton.snp.makeConstraints { make in
            make.trailing.equalTo(mainCardView.snp.trailing).offset(-15)
            make.bottom.equalTo(mainCardView.snp.bottom).offset(-15)
        }
    }

    func configureCell(_ rowData: Movie) {
        dateLabel.text = rowData.convertData
        hashtagLabel.text = "#\(genreIdToString(rowData.genreIds[0]))"
        mainImageView.backgroundColor = .lightGray
        if let imageURL = URL(string: rowData.fullImageURL) {
            mainImageView.kf.setImage(with: imageURL)
        }
        rateLabel.text = rowData.roundRate
        titleLabel.text = rowData.title
        subTitleLabel.text = rowData.description
    }
    
    func genreIdToString(_ genreId: Int) -> String {
        guard let genre = Movie.genreList[genreId] else { return "" }
        return genre
    }
    
//    var model: TrendMovieTableViewCell!

}

//extension TrendMovieTableViewCell: CustomElementModel, CustomElementCell {
//    var type: CustomElementType {
//        return .movie
//    }
//
//    func configure(withModel elementModel: CustomElementModel) {
//
//        print(elementModel)
//        guard let model = elementModel as? TrendMovieTableViewCell else {
//            print("Unable to cast model as ProfileElement: \(elementModel)")
//            return
//        }
//        self.model = model
//    }
//}
