//
//  RegionalViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

//import CoreLocation
import SnapKit
import MapKit
import UIKit

class RegionalViewController: BaseViewController {
    let viewModel = RegionalViewModel()
    
    let mapView = RegionalMapView()
    
    let nbcCoordinate = CLLocationCoordinate2D(latitude: 37.502330, longitude: 127.044466)
    
    let locationManager = CLLocationManager()
    
    lazy var locationList = self.viewModel.fetchweather()
    
    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 권한요청
        locationManager.requestWhenInUseAuthorization()
        mapView.map.delegate = self
        locationManager.delegate = self
        
        addCustomPin()
        
        buttonActions()
    }
    
    func addCustomPin() {
        mapView.map.addAnnotations(locationList)
    }
    
    func buttonActions() {
        mapView.myLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
    }
    
    func goSetting() {
        
        let alert = UIAlertController(title: "위치권한 요청", message: "항상 위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
            
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted:
            print("restricted")
            goSetting()
        case .denied:
            print("denided")
            goSetting()
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wheninuse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("unknown")
        }
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        }
    }
    
    @objc func findMyLocation() {
        guard locationManager.location != nil else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        mapView.map.showsUserLocation = true
        mapView.map.setUserTrackingMode(.follow, animated: true)
    }
}

extension RegionalViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        // nil?
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: "Custom")
        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
            annotationView?.canShowCallout = true
            
            let miniButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            miniButton.setImage(UIImage(systemName: "person"), for: .normal)
            miniButton.tintColor = .blue
            annotationView?.rightCalloutAccessoryView = miniButton
        } else {
            annotationView?.annotation = annotation
        }
        if let title = annotation.title {
            switch title {
            case Region.seoul.rawValue : annotationView?.image = Region.seoul.locationImage
            case Region.gwanak.rawValue : annotationView?.image = UIImage(systemName: "sun.min.fill")
            case Region.uijeongbu.rawValue : annotationView?.image = UIImage(systemName: "sun.max")
            case Region.namyangju.rawValue : annotationView?.image = UIImage(systemName: "sun.max.fill")
            case Region.chuncheon.rawValue : annotationView?.image = UIImage(systemName: "moon")
            case Region.gangneung.rawValue : annotationView?.image = UIImage(systemName: "moon.fill")
            case Region.bucheon.rawValue : annotationView?.image = UIImage(systemName: "cloud")
            case Region.bundang.rawValue : annotationView?.image = UIImage(systemName: "cloud.fill")
            case Region.cheongju.rawValue : annotationView?.image = UIImage(systemName: "cloud.drizzle")
            case Region.andong.rawValue : annotationView?.image = UIImage(systemName: "cloud.drizzle.fill")
            case Region.daegu.rawValue : annotationView?.image = UIImage(systemName: "cloud.bolt")
            case Region.jeonju.rawValue : annotationView?.image = UIImage(systemName: "cloud.bolt.fill")
            case Region.mokpo.rawValue : annotationView?.image = UIImage(systemName: "cloud.sun.fill")
            case Region.yeosu.rawValue : annotationView?.image = UIImage(systemName: "snowflake")
            case Region.changwon.rawValue : annotationView?.image = UIImage(systemName: "wind.snow")
            case Region.busan.rawValue : annotationView?.image = UIImage(systemName: "tornado")
            case Region.jeju.rawValue : annotationView?.image = UIImage(systemName: "aqi.medium")
            case .none:
                print("nil")
            default: annotationView?.image = UIImage(systemName: "heart.fill")
            }
        }
        annotationView?.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        return annotationView
    }
    
    //    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        return self.locationList.count
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return self.locationList[row].title ?? "No title"
    //    }
}

extension RegionalViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
}
