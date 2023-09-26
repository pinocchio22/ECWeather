//
//  RegionalMapView.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/26.
//

import MapKit
import SnapKit
import UIKit

class MapView: UIView {
    
    var myLocationButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("현재 위치로", for: .normal)
        return btn
    }()
    
    let map = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(map)
        self.addSubview(myLocationButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
