//
//  URLSessionViewController.swift
//  SeSAC3Week7PhotoGram
//
//  Created by 한성봉 on 2023/08/30.
//

import UIKit
import SnapKit

class URLSesstionViewController: UIViewController {
    
    var session: URLSession!
    
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            
            if !result.isNaN {
                progressLabel.text = "\(Int(result * 100))%"
            }
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data()
        
        
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(progressLabel)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }

        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main
        )
        
        session.dataTask(with: url!).resume()
    }
    
    // 카카오톡 사진 다운로드: 다운로드 중에 다른 채팅방으로 넘어간다면?, 취소 버튼?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 취소 액션(화면이 사라질 때 등)
        // 리소스 정리, 실행중인 것도 무시.
        session.invalidateAndCancel()
        
        // 기다렸다가 리소스 끝나면 정리
        session.finishTasksAndInvalidate()
    }
    
}

extension URLSesstionViewController: URLSessionDataDelegate {
    // 서버에서 최초로 응답 받은 경우(상태코드 처리)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("Response: \(response)")
        
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!

            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("Data: \(data)") // 1600
        buffer?.append(data)
    }
    
    // 서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
        
        if let error {
            print(error)
        } else {
            guard let buffer = buffer else {
                print(error)
                return
            }
            
            // delegateQueue: .main URLSession에서 이미 main thread에서 작업 시킴
            imageView.image = UIImage(data: buffer)
        }
    }
}
