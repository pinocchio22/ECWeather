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

class RegionalViewController: UIViewController {
    let viewModel = RegionalViewModel()
    
    let mapView = RegionalMapView()
    
    let nbcCoordinate = CLLocationCoordinate2D(latitude: 37.502330, longitude: 127.044466)
    
    let locationManager = CLLocationManager()
    
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
    
//    func addCustomPin() {
//        let pin = MKPointAnnotation()
//        pin.coordinate = nbcCoordinate
//        pin.title = "내배캠"
//        pin.subtitle = "스파르타 코딩클럽"
//        mapView.map.addAnnotation(pin)
//    }
    
    func addCustomPin() {
        var locationList = viewModel.fetchweather()
        mapView.map.addAnnotations(locationList)
    }
    
    func buttonActions() {
        mapView.myLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
        mapView.nbcLocationButton.addTarget(self, action: #selector(findNbcLocation), for: .touchUpInside)
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
    
    @objc func findNbcLocation() {
        mapView.map.showsUserLocation = false
        mapView.map.userTrackingMode = .followWithHeading
        mapView.map.setRegion(MKCoordinateRegion(center: nbcCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.01)), animated: true)
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
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: "Custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
            annotationView?.canShowCallout = true
            
            let miniButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            miniButton.setImage(UIImage(systemName: "person"), for: .normal)
            miniButton.tintColor = .blue
            annotationView?.rightCalloutAccessoryView = miniButton
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(systemName: "heart.fill")
        annotationView?.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        return annotationView
    }
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
