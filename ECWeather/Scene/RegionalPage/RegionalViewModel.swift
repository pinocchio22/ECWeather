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
        CustomAnnotation(title: Region.incheon.rawValue, temperature: "1", coordinate: CLLocationCoordinate2D(latitude: 37.45617301, longitude: 126.7059186)),
        CustomAnnotation(title: Region.seoul.rawValue, temperature: "2", coordinate: CLLocationCoordinate2D(latitude: 37.514575, longitude: 127.0495556)),
        CustomAnnotation(title: Region.uijeongbu.rawValue, temperature: "3", coordinate: CLLocationCoordinate2D(latitude: 37.73528889, longitude: 127.0358417)),
        CustomAnnotation(title: Region.chuncheon.rawValue, temperature: "4", coordinate: CLLocationCoordinate2D(latitude: 37.87854167, longitude: 127.7323111)),
        CustomAnnotation(title: Region.gangneung.rawValue, temperature: "5", coordinate: CLLocationCoordinate2D(latitude: 37.74913611, longitude: 128.8784972)),
        CustomAnnotation(title: Region.suwon.rawValue, temperature: "6", coordinate: CLLocationCoordinate2D(latitude: 37.30101111, longitude: 127.0122222)),
        CustomAnnotation(title: Region.bucheon.rawValue, temperature: "7", coordinate: CLLocationCoordinate2D(latitude: 37.5035917, longitude: 126.766)),
        CustomAnnotation(title: Region.cheongju.rawValue, temperature: "8", coordinate: CLLocationCoordinate2D(latitude: 36.58399722, longitude: 127.5117306)),
        CustomAnnotation(title: Region.andong.rawValue, temperature: "9", coordinate: CLLocationCoordinate2D(latitude: 36.56546389, longitude: 128.7316222)),
        CustomAnnotation(title: Region.daegu.rawValue, temperature: "10", coordinate: CLLocationCoordinate2D(latitude: 35.8715, longitude: 128.6017)),
        CustomAnnotation(title: Region.jeonju.rawValue, temperature: "1", coordinate: CLLocationCoordinate2D(latitude: 35.80918889, longitude: 127.1219194)),
        CustomAnnotation(title: Region.gwangju.rawValue, temperature: "12", coordinate: CLLocationCoordinate2D(latitude: 37.42949814, longitude: 127.2551569)),
        CustomAnnotation(title: Region.mokpo.rawValue, temperature: "13", coordinate: CLLocationCoordinate2D(latitude: 34.80878889, longitude: 126.3944194)),
        CustomAnnotation(title: Region.yeosu.rawValue, temperature: "14", coordinate: CLLocationCoordinate2D(latitude: 34.75731111, longitude: 127.6643861)),
        CustomAnnotation(title: Region.changwon.rawValue, temperature: "15", coordinate: CLLocationCoordinate2D(latitude: 35.2540033, longitude: 128.6401544)),
        CustomAnnotation(title: Region.busan.rawValue, temperature: "16", coordinate: CLLocationCoordinate2D(latitude: 35.16001944, longitude: 129.1658083)),
        CustomAnnotation(title: Region.jeju.rawValue, temperature: "17", coordinate: CLLocationCoordinate2D(latitude: 33.49631111, longitude: 126.5332083))
    ]
    
    func fetchweather() -> [CustomAnnotation] {
        return locationList
    }
    
}
