//
//  MapKitViewController.swift
//  SeSAC3Week6
//
//  Created by 한성봉 on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

enum TheaterType {
    case mage
    case lotte
    case cgv
    case all
}

class MapKitViewController: UIViewController {
    
    lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        button.tintColor = .black
        return button
    }()
    
    let homeButton: UIButton = {
        let bnt = UIButton()
        bnt.setImage(UIImage(systemName: "house.fill"), for: .normal)
        bnt.tintColor = .black
        return bnt
    }()
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    let theater: TheaterList = TheaterList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
    
        view.addSubview(mapView)
        view.addSubview(homeButton)
        
        setConstraints()
        setNavigationBar()
        checkDeviceLocationAuthorization()
        setAnnotation(type: .all)
        
        homeButton.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
        
        homeButton.addTarget(self, action: #selector(homeButtonClicked), for: .touchUpInside)
    }
    
    @objc func homeButtonClicked() {
        print(#function)
        // 37.603846, 127.033278 // 마이 홈
        let center = CLLocationCoordinate2D(latitude: 37.603846, longitude: 127.033278)
        setRegionAndAnnotation(center: center)
    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func filterButtonTapped() {
        print(#function)
        showFilterAlert()
    }
    
    func setAnnotation(type: TheaterType) {
        switch type {
        case .mage:
            let theaterList = theater.mapAnnotations.filter { $0.type == "메가박스" }
            setPointAnnotation(theatherList: theaterList)
        case .lotte:
            let theaterList = theater.mapAnnotations.filter { $0.type == "롯데시네마" }
            setPointAnnotation(theatherList: theaterList)
        case .cgv:
            let theaterList = theater.mapAnnotations.filter { $0.type == "CGV" }
            setPointAnnotation(theatherList: theaterList)
        case .all:
            setPointAnnotation(theatherList: theater.mapAnnotations)
        }
    }
    
    func setPointAnnotation(theatherList: [Theater]) {
        var pointAnnotationList = [MKPointAnnotation]()
        for item in theatherList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: item.latitude,
                longitude: item.longitude
            )
            annotation.title = item.location
            annotation.subtitle = "영화관"
            pointAnnotationList.append(annotation)
        }
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(pointAnnotationList)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이동", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'애서 위치 서비스를 켜주세요'", preferredStyle: .alert)
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
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
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
                print("위치 서비스가 꺼져 있어 위치 권한 요청을 못합니다.")
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("check", status)
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
            // 37.518448, 126.884938 => 새싹
            let center = CLLocationCoordinate2D(latitude: 37.518448, longitude: 126.884938)
            setRegionAndAnnotation(center: center)
            
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse") // 한 번 허용 눌렀을 경우
            locationManager.startUpdatingLocation() // didUpdateLocation() 메서드 호출
        case .authorized:
            print("authorized")
        @unknown default:
            print("default")
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension MapKitViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        // 현재 위치 가져옴
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate)

        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    // @deprecated
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
}

// MARK: - MKMapViewDelegate


extension MapKitViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
        
    }
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            
            // callout mini button
            let miniButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            miniButton.setImage(UIImage(systemName: "person"), for: .normal)
            miniButton.tintColor = .black
            annotationView?.rightCalloutAccessoryView = miniButton
            
            let annotationLabel = UILabel(frame: CGRect(x: -40, y: 15, width: 105, height: 30))
            annotationLabel.numberOfLines = 3
            annotationLabel.textAlignment = .center
            annotationLabel.font = .boldSystemFont(ofSize: 11)
            
            guard let title = annotationView?.annotation?.title else {
                return nil
            }
            annotationLabel.text = title
            annotationView?.addSubview(annotationLabel)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(systemName: "pawprint.circle")
        
        return annotationView
    }
}

// MARK: - Extension - MapKitViewController

extension MapKitViewController {
    func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "지도"
     
        addBackButton()
        addRightButton()
        
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func addRightButton() {
        self.navigationItem.rightBarButtonItem = self.filterButton
    }
    
    func setConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func showFilterAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            print("megabox")
            self.setAnnotation(type: .mage)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            print("lotte")
            self.setAnnotation(type: .lotte)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            print("cgv")
            self.setAnnotation(type: .cgv)
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            print("all")
            self.setAnnotation(type: .all)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(megabox)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(all)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
