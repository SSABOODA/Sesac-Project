//
//  NetflixMainViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/24.
//

import UIKit
import SnapKit

class NetflixMainViewController: UIViewController {

    
    let backImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    let mainImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "어벤져스엔드게임")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let mainView = {
        let view = UIView()
        return view
    }()
    
    let logoButton = {
        let bnt = UIButton()
        bnt.tintColor = .white
        bnt.setTitle("N", for: .normal)
        bnt.titleLabel?.font = .boldSystemFont(ofSize: 70)
        return bnt
    }()
    
    let menu1Label = {
        let lb = MainViewMenuLabel()
        lb.text = "TV프로그램"
        return lb
    }()
    
    let menu2Label = {
        let lb = MainViewMenuLabel()
        lb.text = "영화"
        return lb
    }()
    
    let menu3Label = {
        let lb = MainViewMenuLabel()
        lb.text = "내가 찜한 콘텐츠"
        return lb
    }()
    
    let pickButton = {
        let bnt = UIButton()
        bnt.setImage(UIImage(systemName: "checkmark"), for: .normal)
        bnt.tintColor = .white
        return bnt
    }()
    
    let pickLabel = {
        let lb = UILabel()
        lb.text = "내가 찜한 콘텐츠"
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()
    
    let playImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.image = UIImage(named: "play_normal")
        return view
    }()
    
    let infoButton = {
        let bnt = UIButton()
        bnt.setImage(UIImage(systemName: "info.circle"), for: .normal)
        bnt.tintColor = .white
        return bnt
    }()
    
    let infoLabel = {
        let lb = UILabel()
        lb.text = "정보"
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()
    
    let previewLabel = {
        let lb = UILabel()
        lb.text = "미리 보기"
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    let previewImageView1 = {
        let view = PreviewImageView(frame: CGRect(x: 0, y: 0, width: 115, height: 115))
        view.image = UIImage(named: "겨울왕국2")
        return view
    }()
    
    let previewImageView2 = {
        let view = PreviewImageView(frame: CGRect(x: 0, y: 0, width: 115, height: 115))
        view.image = UIImage(named: "부산행")
        return view
    }()
    
    let previewImageView3 = {
        let view = PreviewImageView(frame: CGRect(x: 0, y: 0, width: 115, height: 115))
        view.image = UIImage(named: "명량")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(mainImageView)
        view.addSubview(backImageView)
        
        view.addSubview(mainView)
        view.addSubview(logoButton)
        view.addSubview(menu1Label)
        view.addSubview(menu2Label)
        view.addSubview(menu3Label)
        view.addSubview(pickButton)
        view.addSubview(pickLabel)
        view.addSubview(playImageView)
        view.addSubview(infoButton)
        view.addSubview(infoLabel)
        view.addSubview(previewLabel)
        view.addSubview(previewImageView1)
        view.addSubview(previewImageView2)
        view.addSubview(previewImageView3)
        
        setConstraints()
    }
    
    func setConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        logoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        menu1Label.snp.makeConstraints { make in
            make.top.equalTo(logoButton.snp.top).offset(50)
            make.leading.equalTo(logoButton.snp.trailing).offset(30)
        }
        
        menu2Label.snp.makeConstraints { make in
            make.top.equalTo(logoButton.snp.top).offset(50)
            make.leading.equalTo(menu1Label.snp.trailing).offset(30)
        }
        
        menu3Label.snp.makeConstraints { make in
            make.top.equalTo(logoButton.snp.top).offset(50)
            make.leading.equalTo(menu2Label.snp.trailing).offset(30)
        }
        
        previewImageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.size.equalTo(115)
        }
        
        previewImageView1.snp.makeConstraints { make in
            make.trailing.equalTo(previewImageView2.snp.leading).offset(-15)
            make.bottom.equalToSuperview().offset(-50)
            make.size.equalTo(115)
        }
        
        previewImageView3.snp.makeConstraints { make in
            make.leading.equalTo(previewImageView2.snp.trailing).offset(15)
            make.bottom.equalToSuperview().offset(-50)
            make.size.equalTo(115)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.bottom.equalTo(previewImageView1.snp.top).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        playImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(previewImageView2.snp.top).offset(-70)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }
        
        pickLabel.snp.makeConstraints { make in
            make.trailing.equalTo(playImageView.snp.leading).offset(-20)
            make.bottom.equalTo(previewLabel.snp.top).offset(-35)
        }
        
        pickButton.snp.makeConstraints { make in
            make.centerX.equalTo(pickLabel.snp.centerX)
            make.bottom.equalTo(pickLabel.snp.top).offset(-10)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(playImageView.snp.trailing).offset(50)
            make.bottom.equalTo(previewLabel.snp.top).offset(-35)
        }
        
        infoButton.snp.makeConstraints { make in
            make.centerX.equalTo(infoLabel.snp.centerX)
            make.bottom.equalTo(infoLabel.snp.top).offset(-10)
        }
    }
}
