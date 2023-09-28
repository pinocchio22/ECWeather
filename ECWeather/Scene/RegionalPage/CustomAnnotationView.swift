//
//  CustomAnnotationView.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/28.
//

import UIKit
import MapKit
import SnapKit

class CustomAnnotationView: MKAnnotationView {
    
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
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(customImageView)
        backgroundView.addSubview(temperatureLabel)
        
        backgroundView.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        customImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(customImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customImageView.image = nil
        titleLabel.text = nil
    }
    

    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? CustomAnnotation else { return }
        
        titleLabel.text = annotation.title
        customImageView.image = annotation.iconImage
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bounds.size = CGSize(width: 80, height: 80)
           centerOffset = CGPoint(x: 0, y: 40)
    }
}
