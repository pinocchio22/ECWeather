//
//  CustomCalloutView.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/28.
//

import SnapKit
import UIKit

class CustomCalloutView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let viewModel = RegionalViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 10)
            $0.height.equalTo(50)
        }
    }
    
    private func setCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(TemperatureCollectionViewCell.self, forCellWithReuseIdentifier: "TemperatureCollectionViewCell")
    }
    
//    func getDailyWeather(cityName: String) -> [CustomWeeklyWeather] {
//        print("@@@@@@@@@ 1      \(DataManager.shared.currentLocation)")
//        print("@@@@@@@@@ 2 \(cityName)")
//        var weatherList = [CustomWeeklyWeather]()
//        viewModel.getDailyWeather(cityName: cityName) { weather in
//            print("@@@@@@@@@ \(weather?.count)")
//            if let weather = weather {
//                weatherList = weather.filter { $0.dateTime.toDate()?.toDayString() == DataManager.shared.currentLocation }
//            }
//        }
//        return weatherList
//    }
}

//extension CustomCalloutView: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("@@@@@ \(getDailyWeather(cityName: DataManager.shared.currentLocation).count)")
//        return getDailyWeather(cityName: DataManager.shared.currentLocation).count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemperatureCollectionViewCell", for: indexPath) as? TemperatureCollectionViewCell else { return UICollectionViewCell() }
//        cell.timeLabel.text = getDailyWeather(cityName: DataManager.shared.currentLocation)[indexPath.row].dateTime
//        cell.temperatureLabel.text = "\(getDailyWeather(cityName: DataManager.shared.currentLocation)[indexPath.row].currentTemp)℃"
//
//        return cell
//    }
//}
