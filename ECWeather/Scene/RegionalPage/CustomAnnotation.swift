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
    var subtitle: String?
    var iconImage: UIImage?
    var coordinate: CLLocationCoordinate2D

    init(title: String? = nil, subtitle: String? = nil, iconImage: UIImage? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.iconImage = iconImage
        self.coordinate = coordinate
    }
}
