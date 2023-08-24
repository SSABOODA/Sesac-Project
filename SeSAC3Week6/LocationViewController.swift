//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/22.
//

import UIKit
import CoreLocation // 1. CoreLocation Import
import MapKit
import SnapKit

class LocationViewController: UIViewController {
    
    // 2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    
    let martButton = UIButton()
    let schoolButton = UIButton()
    
    let num = Int.random(in: 1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(50)
        }
        
        view.addSubview(martButton)
        view.addSubview(schoolButton)
        martButton.backgroundColor = .systemRed
        martButton.addTarget(self, action: #selector(martButtonClicked), for: .touchUpInside)
        martButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(120)
            make.size.equalTo(50)
            make.leading.equalTo(view).offset(100)
        }
    
        schoolButton.backgroundColor = .systemBlue
        schoolButton.addTarget(self, action: #selector(schoolButtonClicked), for: .touchUpInside)
        schoolButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(120)
            make.size.equalTo(50)
            make.trailing.equalTo(view).offset(-100)
        }
        
        view.backgroundColor = .white
        
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization() // iOS 위치 서비스 활성화 체크
        
        let center = CLLocationCoordinate2D(latitude: 37.60385, longitude: 127.03328)
        setRegionAndAnnotation(center: center)
        setAnnotation(type: 0)
    }
    
    @objc func martButtonClicked() {
        print(#function)
        setAnnotation(type: 1)
    }
    
    @objc func schoolButtonClicked() {
        
    }
    
    
    
    func setAnnotation(type: Int) {
        // 37.604709, 127.031089 이마트
        // 37.607431, 127.032533 서울 과기고
        
        let emart = (37.604709, 127.031089)
        let school = (37.607431, 127.032533)
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: emart.0, longitude: emart.1)
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: school.0, longitude: school.1)
        
        if type == 0 { // viewDidLoad
            mapView.addAnnotations([annotation1, annotation2])
        } else if type == 1 {
//            mapView.removeAnnotation(annotation1) // 이 코드가 작동안하는 이유에 대해서 한번 생각해보기
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation2])
        }
    }
    
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        //지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
        
        // 지도에 어노테이션 추가
        let annotation = MKPointAnnotation() // 애플 기본 핀 모양
        annotation.title = "마이 홈"
        annotation.coordinate = center
        mapView.addAnnotation(annotation) // 핀 한개
//        mapView.addAnnotations(<#T##annotations: [MKAnnotation]##[MKAnnotation]#>) // 핀 여러개
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        // 설정에서 직접적으로 앱 설정 화면에 들어간적이 없다면
        // 한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이라서
        // 설정 페이지로 넘어갈지, 설정 상세 페이지 결정 X
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                print("appSetting: \(appSetting)")
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
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
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
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
            showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation() // didUpdateLocation 메서드 호출
        case .authorized:
            print("authorized")
        @unknown default: // 위치 권한 종류가 더 생길 가능성 대비
            print("default")
        }
    }
    
}

// 4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    // 한번만 실행되지 않는다. iOS 위치 업데이트가 필요한 시점에 알아서 여러번 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate)
            
//            let lat = coordinate.latitude // 위도
//            let lon = coordinate.longitude // 경도
//            print(lat, lon)
        }
        
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

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print(#function)
//    }
}
