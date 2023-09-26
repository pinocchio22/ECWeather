//
//  CustomAnnotation.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/26.
//

import MapKit
import UIKit

class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var temperature: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(title: String, temperature: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.temperature = temperature
        self.coordinate = coordinate
    }
}
