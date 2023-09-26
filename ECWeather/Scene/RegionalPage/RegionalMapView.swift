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
        btn.backgroundColor = .darkGray
        btn.setTitleColor(.yellow, for: .normal)
        return btn
    }()
    
    let map = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(map)
        self.addSubview(myLocationButton)
        
        configureUI()
        makeConstraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
    }
    
    func makeConstraintUI() {
        map.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
    }
    
}
