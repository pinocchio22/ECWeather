//
//  SettingViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import UIKit
import SnapKit
import MapKit

class SettingViewController: BaseViewController {
    
    /// 설정 title label
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.textColor = .ECWeatherColor3
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    /// main table view
    lazy var mainTableView: UITableView = {
        let tableview = UITableView()
        tableview.layer.cornerRadius = 10
        return tableview
    }()
    
    let items: [String] = ["단위 변환", "현재 위치 재설정", "지역 추가"]
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableview()
        setLayout()
    }
    
    func registerTableview() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
    }
    
    func setLayout() {
        view.addSubview(titleLabel)
        view.addSubview(mainTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view).offset(34)
        }
        
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp_bottomMargin).offset(30)
            $0.leading.equalTo(view).offset(20)
            $0.trailing.equalTo(view).offset(-20)
            $0.bottom.equalTo(view)
        }
    }
    
    func goSetting() {
        let alert = UIAlertController(title: "위치권한 요청", message: "항상 위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
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
}

extension SettingViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            print("현재 위치 - 위도: \(latitude), 경도: \(longitude)")
            DataManager.shared.latitude = latitude
            DataManager.shared.longitude = longitude
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = items[indexPath.row]
        cell.segmentedControl.isHidden = indexPath.row != 0
        cell.segmentedControl.tag = indexPath.row
        cell.segmentedControl.selectedSegmentIndex = DataManager.shared.temperatureType
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let vc = SearchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            DataManager.shared.temperatureType = DataManager.shared.temperatureType == 0 ? 1 : 0
            tableView.reloadData()
        }
    }
    
    @objc func didChangeValueSegement(_ sender: UISegmentedControl) {
        sender.selectedSegmentIndex = (sender.selectedSegmentIndex != 0) ? 0 : 1
        mainTableView.reloadData()
    }
}
