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
        
        viewModel.getCustomAnnotation(cityName: "Seoul") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Seoul" }?.title = "서울"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Uijeongbu-si") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Uijeongbu-si" }?.title = "의정부"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Namyangju") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Namyangju" }?.title = "남양주"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "chuncheon") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "chuncheon" }?.title = "춘천"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "gangneung") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "gangneung" }?.title = "강릉"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Bucheon-si") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Bucheon-si" }?.title = "부천"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Seongnam-si") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Seongnam-si" }?.title = "성남"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Cheongju-si") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Cheongju-si" }?.title = "청주"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Andong") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Andong" }?.title = "안동"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Daegu") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Daegu" }?.title = "대구"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Jeonju") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Jeonju" }?.title = "전주"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Mokpo") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Mokpo" }?.title = "목표"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Changwon") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Changwon" }?.title = "창원"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Busan") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Busan" }?.title = "부산"
            self.addCustomPin()
        }
        
        viewModel.getCustomAnnotation(cityName: "Jeju-do") { item in
            self.locationList.append(item!)
            self.locationList.first { $0.title == "Jeju-do" }?.title = "제주"
            self.addCustomPin()
            
            self.indicator.stopAnimating()
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
            
            let customCalloutView = CustomCalloutView()
            annotationView?.detailCalloutAccessoryView = customCalloutView
        }
        return annotationView
    }
    
    // TODO: callout의 타이틀을 없애거나 위치를 조정하거나..
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {}
}

extension RegionalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = "관악구"
        return cell
    }
}
