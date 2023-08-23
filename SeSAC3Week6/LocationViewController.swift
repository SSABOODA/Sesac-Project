//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit
import CoreLocation // 1. CoreLocation Import

class LocationViewController: UIViewController {
    
    // 2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization() // // iOS 위치 서비스 활성화 체크
        
    }
    
    func checkDeviceLocationAuthorization() {
        
        // iOS 위치 서비스 활성화 체크
        // 위치 권한 체크는 비동기로 처리해야함.
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                // 현재 사용자의 위치 권한 상태를 가지고 옴
                let authorization: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                print(authorization)
                self.checkCurrentLocationAuthorization(status: authorization)
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("Check", status)
        
//        @frozen >> 더 이상 열거형에 절대 추가될 케이스가 없다고 확인한다.!!!
        
        switch status {
        case .notDetermined:
            // 위치 업뎃 정확도
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // info.plist <<< alert
            // 권한 허용 alert 띄우는 코드
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation() // didUpdateLocation 메서드 호출
        case .authorized:
            print("authorized")
        @unknown default: // 위치 권한 종류가 더 생길 가능성 대비
            print("Error")
        }
    }
    
}

// 4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    // 한번만 실행되지 않는다. iOS 위치 업데이트가 필요한 시점에 알아서 여러번 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print("=======", locations)
        
        locationManager.stopUpdatingLocation() // 한번만 위치를 업데이트하고 싶은 경우 호출
    }
    
    // 사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    // 사용자의 권한 상태가 바뀔 때를 알려줌
    // 거부했다가 설정에서 변경을 했거나, 혹은 notDetermined 상태에서 허용을 했거나
    // 허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    // iOS 14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    // deprecated
    // 사용자의 권한 상태가 바뀔 때를 알려줌
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}


