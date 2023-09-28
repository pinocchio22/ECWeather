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
        CustomAnnotation(title: Region.seoul.rawValue, subtitle: "1", iconImage: UIImage(systemName: "sun.min")!, coordinate: CLLocationCoordinate2D(latitude: 37.514575, longitude: 127.0495556)),
        CustomAnnotation(title: Region.gwanak.rawValue, subtitle: "2", iconImage: UIImage(systemName: "sun.min.fill")!, coordinate: CLLocationCoordinate2D(latitude: 37.47538611, longitude: 126.9538444)),
        CustomAnnotation(title: Region.uijeongbu.rawValue, subtitle: "3", iconImage: UIImage(systemName: "sun.max")!, coordinate: CLLocationCoordinate2D(latitude: 37.73528889, longitude: 127.0358417)),
        CustomAnnotation(title: Region.namyangju.rawValue, subtitle: "4", iconImage: UIImage(systemName: "sun.max.fill")!, coordinate: CLLocationCoordinate2D(latitude: 37.63317778, longitude: 127.2186333)),
        CustomAnnotation(title: Region.chuncheon.rawValue, subtitle: "4", iconImage: UIImage(systemName: "moon")!, coordinate: CLLocationCoordinate2D(latitude: 37.87854167, longitude: 127.7323111)),
        CustomAnnotation(title: Region.gangneung.rawValue, subtitle: "5", iconImage: UIImage(systemName: "moon.fill")!, coordinate: CLLocationCoordinate2D(latitude: 37.74913611, longitude: 128.8784972)),
        CustomAnnotation(title: Region.bucheon.rawValue, subtitle: "7", iconImage: UIImage(systemName: "cloud")!, coordinate: CLLocationCoordinate2D(latitude: 37.5035917, longitude: 126.766)),
        CustomAnnotation(title: Region.bundang.rawValue, subtitle: "7", iconImage: UIImage(systemName: "cloud.fill")!, coordinate: CLLocationCoordinate2D(latitude: 37.44749167, longitude: 127.1477194)),
        CustomAnnotation(title: Region.cheongju.rawValue, subtitle: "8", iconImage: UIImage(systemName: "cloud.drizzle")!, coordinate: CLLocationCoordinate2D(latitude: 36.58399722, longitude: 127.5117306)),
        CustomAnnotation(title: Region.andong.rawValue, subtitle: "9", iconImage: UIImage(systemName: "cloud.drizzle.fill")!, coordinate: CLLocationCoordinate2D(latitude: 36.56546389, longitude: 128.7316222)),
        CustomAnnotation(title: Region.daegu.rawValue, subtitle: "10", iconImage: UIImage(systemName: "cloud.bolt")!, coordinate: CLLocationCoordinate2D(latitude: 35.8715, longitude: 128.6017)),
        CustomAnnotation(title: Region.jeonju.rawValue, subtitle: "1", iconImage: UIImage(systemName: "cloud.bolt.fill")!, coordinate: CLLocationCoordinate2D(latitude: 35.80918889, longitude: 127.1219194)),
        CustomAnnotation(title: Region.mokpo.rawValue, subtitle: "13", iconImage: UIImage(systemName: "cloud.sun.fill")!, coordinate: CLLocationCoordinate2D(latitude: 34.80878889, longitude: 126.3944194)),
        CustomAnnotation(title: Region.yeosu.rawValue, subtitle: "14", iconImage: UIImage(systemName: "snowflake")!, coordinate: CLLocationCoordinate2D(latitude: 34.75731111, longitude: 127.6643861)),
        CustomAnnotation(title: Region.changwon.rawValue, subtitle: "15", iconImage: UIImage(systemName: "wind.snow")!, coordinate: CLLocationCoordinate2D(latitude: 35.2540033, longitude: 128.6401544)),
        CustomAnnotation(title: Region.busan.rawValue, subtitle: "16", iconImage: UIImage(systemName: "tornado")!, coordinate: CLLocationCoordinate2D(latitude: 35.15995278, longitude: 129.0553194)),
        CustomAnnotation(title: Region.jeju.rawValue, subtitle: "17", iconImage: UIImage(systemName: "aqi.medium")!, coordinate: CLLocationCoordinate2D(latitude: 33.49631111, longitude: 126.5332083)),
    ]

    func fetchweather() -> [CustomAnnotation] {
        return locationList
    }
    
}
