//
//  SearchTableViewCell.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/27.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    var weatherData: [CustomWeeklyWeather]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerTableview()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerTableview() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TemperatureCollectionViewCell.self, forCellWithReuseIdentifier: "TemperatureCollectionViewCell")
    }
    
    func setLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(100)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        getWeeklyWeatherAPI()
    }
    
    func getWeeklyWeatherAPI() {
        for i in DataManager.shared.searchKeyword {
            NetworkService.getWeeklyWeather(cityName: i) { data in
                self.weatherData = data?.filter { i in
                    i.dateTime.toDate()?.toString() == Date().toString()
                }
                Util.print(output: self.weatherData)
                self.collectionView.reloadData()
            }
        }
    }
}

extension SearchTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemperatureCollectionViewCell", for: indexPath) as? TemperatureCollectionViewCell else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 10
        cell.timeLabel.text = "\(weatherData?[indexPath.row].dateTime.toDate()?.toTimeString() ?? "")시"
        cell.temperatureLabel.text = "\(Int(weatherData?[indexPath.row].currentTemp ?? 0))°"
        NetworkService.getIcon(iconCode: weatherData?[indexPath.row].icon ?? "") { icon in
            DispatchQueue.main.async {
                cell.weatherImage.image = UIImage(data: icon ?? Data())
            }
        }
        return cell
    }
}
