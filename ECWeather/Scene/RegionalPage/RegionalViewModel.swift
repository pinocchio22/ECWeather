//
//  RegionalViewModel.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/26.
//

import Foundation
import MapKit

class RegionalViewModel {
    var locationList = [
        CustomAnnotation(title: Region.seoul.rawValue, subtitle: "1", coordinate: CLLocationCoordinate2D(latitude: 37.514575, longitude: 127.0495556)),
        CustomAnnotation(title: Region.gwanak.rawValue, subtitle: "2", coordinate: CLLocationCoordinate2D(latitude: 37.47538611, longitude: 126.9538444)),
        CustomAnnotation(title: Region.uijeongbu.rawValue, subtitle: "3", coordinate: CLLocationCoordinate2D(latitude: 37.73528889, longitude: 127.0358417)),
        CustomAnnotation(title: Region.namyangju.rawValue, subtitle: "4", coordinate: CLLocationCoordinate2D(latitude: 37.63317778, longitude: 127.2186333)),
        CustomAnnotation(title: Region.chuncheon.rawValue, subtitle: "4", coordinate: CLLocationCoordinate2D(latitude: 37.87854167, longitude: 127.7323111)),
        CustomAnnotation(title: Region.gangneung.rawValue, subtitle: "5", coordinate: CLLocationCoordinate2D(latitude: 37.74913611, longitude: 128.8784972)),
        CustomAnnotation(title: Region.bucheon.rawValue, subtitle: "7", coordinate: CLLocationCoordinate2D(latitude: 37.5035917, longitude: 126.766)),
        CustomAnnotation(title: Region.bundang.rawValue, subtitle: "7", coordinate: CLLocationCoordinate2D(latitude: 37.44749167, longitude: 127.1477194)),
        CustomAnnotation(title: Region.cheongju.rawValue, subtitle: "8", coordinate: CLLocationCoordinate2D(latitude: 36.58399722, longitude: 127.5117306)),
        CustomAnnotation(title: Region.andong.rawValue, subtitle: "9", coordinate: CLLocationCoordinate2D(latitude: 36.56546389, longitude: 128.7316222)),
        CustomAnnotation(title: Region.daegu.rawValue, subtitle: "10", coordinate: CLLocationCoordinate2D(latitude: 35.8715, longitude: 128.6017)),
        CustomAnnotation(title: Region.jeonju.rawValue, subtitle: "1", coordinate: CLLocationCoordinate2D(latitude: 35.80918889, longitude: 127.1219194)),
        CustomAnnotation(title: Region.mokpo.rawValue, subtitle: "13", coordinate: CLLocationCoordinate2D(latitude: 34.80878889, longitude: 126.3944194)),
        CustomAnnotation(title: Region.yeosu.rawValue, subtitle: "14", coordinate: CLLocationCoordinate2D(latitude: 34.75731111, longitude: 127.6643861)),
        CustomAnnotation(title: Region.changwon.rawValue, subtitle: "15", coordinate: CLLocationCoordinate2D(latitude: 35.2540033, longitude: 128.6401544)),
        CustomAnnotation(title: Region.busan.rawValue, subtitle: "16", coordinate: CLLocationCoordinate2D(latitude: 35.15995278, longitude: 129.0553194)),
        CustomAnnotation(title: Region.jeju.rawValue, subtitle: "17", coordinate: CLLocationCoordinate2D(latitude: 33.49631111, longitude: 126.5332083))
    ]
    
    func fetchweather() -> [CustomAnnotation] {
        return locationList
    }
    
}
