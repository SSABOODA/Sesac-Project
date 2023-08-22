//
//  Example3ViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit

class Example3ViewController: UIViewController {
    
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "10월 24일 09시 42분"
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()
    
    let locationButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "location.fill"), for: .normal)
        bt.tintColor = .white
        return bt
    }()
    
    let locationLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        lb.text = "서울, 신림동"
        return lb
    }()
    
    let shareButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        bt.tintColor = .white
        return bt
    }()
    
    let resetButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        bt.tintColor = .white
        return bt
    }()
    
    // chat
    let firstChatLabel: BasePaddingLabel = {
        let lb = BasePaddingLabel()
        lb.backgroundColor = .white
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20)
        lb.text = "지금은 9℃에요"
        lb.layer.cornerRadius = 10
        lb.clipsToBounds = true
        return lb
    }()
    
    let secondChatLabel: BasePaddingLabel = {
        let lb = BasePaddingLabel()
        lb.backgroundColor = .white
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20)
        lb.text = "78% 만큼 습해요"
        lb.layer.cornerRadius = 10
        lb.clipsToBounds = true
        return lb
    }()
    
    let thirdChatLabel: BasePaddingLabel = {
        let lb = BasePaddingLabel()
        lb.backgroundColor = .white
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20)
        lb.text = "1m/s의 바림이 불어요"
        lb.layer.cornerRadius = 10
        lb.clipsToBounds = true
        return lb
    }()
    
    let fourthChatLabel: BasePaddingLabel = {
        let lb = BasePaddingLabel()
        lb.backgroundColor = .white
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20)
        lb.text = "오늘도 행복한 하루를 보내세요"
        lb.layer.cornerRadius = 10
        lb.clipsToBounds = true
        return lb
    }()
    
    let chatImageView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "cloud")
        imv.layer.cornerRadius = 10
        imv.clipsToBounds = true
        return imv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        let uiSet = [
            dateLabel,
            locationButton,
            locationLabel,
            
            resetButton,
            shareButton,
            
            firstChatLabel,
            secondChatLabel,
            thirdChatLabel,
            fourthChatLabel,
            chatImageView,
        ]
        
        uiSet.forEach { view.addSubview($0) }
        setConstraints()
        
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
    }
    
    @objc func resetButtonClicked() {
        dismiss(animated: true)
    }
    
    func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        locationButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)

        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.leading.equalTo(locationButton.snp.trailing).offset(15)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-25)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.trailing.equalTo(resetButton.snp.leading).offset(-30)
        }
        
        firstChatLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.top.equalTo(locationButton.snp.bottom).offset(15)
        }
        
        secondChatLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.top.equalTo(firstChatLabel.snp.bottom).offset(15)
        }
        
        thirdChatLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.top.equalTo(secondChatLabel.snp.bottom).offset(15)
        }
        
        chatImageView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.top.equalTo(thirdChatLabel.snp.bottom).offset(15)
            make.height.equalTo(200)
            make.width.equalTo(250)
        }
        
        fourthChatLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.top.equalTo(chatImageView.snp.bottom).offset(15)
        }
        
        


        
        
    }
    

}
