//
//  CustomCalloutView.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/28.
//

import SnapKit
import UIKit

class CustomCalloutView: UIView {
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.8)
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .ECWeatherColor2
        label.backgroundColor = .ECWeatherColor3
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        return label
    }()
    
    lazy var customImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.image = UIImage(systemName: "pencil")
        return view
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "18 / 27"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(customImageView)
        backgroundView.addSubview(temperatureLabel)
        
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        customImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(customImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind(title: String, subTitle: String, image: UIImage) {
        titleLabel.text = title
        temperatureLabel.text = subTitle
        customImageView.image = image
    }
}
