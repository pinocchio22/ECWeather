//
//  RegionalViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import MapKit
import SnapKit
import UIKit

class RegionalViewController: BaseViewController {
    private let viewModel = RegionalViewModel()
    
    private let mapView = RegionalMapView()

    private lazy var locationList: [CustomAnnotation] = []
    
    private let indicator: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }()
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.map.delegate = self

        setUpIndicator()
        addCustomPin()
        buttonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicator.startAnimating()
        getLoactionWeather()
    }
    
    private func setUpIndicator() {
        view.addSubview(indicator)
        
        let newSize = CGSize(width: 100, height: 100)
        indicator.transform = CGAffineTransform(scaleX: newSize.width / indicator.bounds.size.width, y: newSize.height / indicator.bounds.size.height)
        indicator.color = .ECWeatherColor3
        indicator.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getLoactionWeather() {
        removeAnnotation()
        DataManager.shared.locationList.forEach { location in
            self.viewModel.getCustomAnnotation(cityName: location) { annotation in
                if let annotation = annotation {
                    self.locationList.append(annotation)
                    self.addCustomPin()
                }
                self.indicator.stopAnimating()
            }
        }
    }
    
    private func removeAnnotation() {
        locationList = []
        mapView.map.annotations.forEach { annotation in
            mapView.map.removeAnnotation(annotation)
        }
    }
    
    private func addCustomPin() {
        mapView.map.addAnnotations(locationList)
        mapView.map.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotationView.self))
    }
    
    private func buttonActions() {
        mapView.myLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
    }
    
    private func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let currentDate = dateFormatter.string(from: date)
        return currentDate
    }
    
    @objc func findMyLocation() {
        mapView.map.showsUserLocation = true
        mapView.map.setUserTrackingMode(.follow, animated: true)
        
        viewModel.getMyLocationAnnotation(latitude: DataManager.shared.latitude!, longitude: DataManager.shared.longitude!) { item in
            self.mapView.map.addAnnotation(item!)
        }
    }
}

extension RegionalViewController: MKMapViewDelegate {
    func setupAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        // dequeueReusableAnnotationView: 식별자를 확인하여 사용가능한 뷰가 있으면 해당 뷰를 반환
        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(CustomAnnotationView.self), for: annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 현재 위치 표시(점)도 일종에 어노테이션이기 때문에, 이 처리를 안하게 되면, 유저 위치 어노테이션도 변경 된다.
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        // 다운캐스팅이 되면 CustomAnnotation를 갖고 CustomAnnotationView를 생성
        if let customAnnotation = annotation as? CustomAnnotation {
            annotationView = setupAnnotationView(for: customAnnotation, on: mapView)
            annotationView?.canShowCallout = true
            
//            let customCalloutView = CustomCalloutView()
//            annotationView?.detailCalloutAccessoryView = customCalloutView
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if let title = view.annotation?.title {
//            DataManager.shared.currentLocation = title ?? ""
//        }
//        print("@@@@@@@@@ didSelect \(DataManager.shared.currentLocation)")
    }
}
