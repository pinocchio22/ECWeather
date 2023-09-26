//
//  RegionalViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

//import CoreLocation
import MapKit
import UIKit

class RegionalViewController: UIViewController {
    
    let mapView = RegionalMapView()
    
    let nbcCoordinate = CLLocationCoordinate2D(latitude: 37.502330, longitude: 127.044466)
    
    let locationManager = CLLocationManager()
    
    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 권한요청
//        locationManager.requestWhenInUseAuthorization()
        mapView.map.delegate = self
        locationManager.delegate = self
    }
}

extension RegionalViewController: MKMapViewDelegate {
    
}

extension RegionalViewController: CLLocationManagerDelegate {
    
}
