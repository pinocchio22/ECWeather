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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(timeLabel)
        self.addSubview(weatherImage)
        self.addSubview(temperatureLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        weatherImage.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImage.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.backgroundColor = .ECWeatherColor4
    }
    
}
