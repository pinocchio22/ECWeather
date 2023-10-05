//
//  RegionalMapView.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/26.
//

import MapKit
import SnapKit
import UIKit

class RegionalMapView: UIView {
    var myLocationButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("현재 위치로", for: .normal)
        btn.backgroundColor = .ECWeatherColor3
        btn.setTitleColor(.ECWeatherColor4, for: .normal)
        return btn
    }()
    
    private var nbcLocationButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("내배캠", for: .normal)
        btn.backgroundColor = .ECWeatherColor3
        btn.setTitleColor(.ECWeatherColor4, for: .normal)
        return btn
    }()
    
    let map = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(map)
        addSubview(myLocationButton)
        
        configureUI()
        makeConstraintUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {}
    
    private func makeConstraintUI() {
        map.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
    }
}
