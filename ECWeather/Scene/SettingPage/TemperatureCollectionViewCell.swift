//
//  TemperatureCollectionViewCell.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/27.
//

import UIKit

class TemperatureCollectionViewCell: UICollectionViewCell {
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        addSubview(timeLabel)
        addSubview(weatherImage)
        addSubview(temperatureLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(weatherImage.snp.top)
        }
        
        weatherImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.equalTo(temperatureLabel.snp.top)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        backgroundColor = .ECWeatherColor4
    }
}
