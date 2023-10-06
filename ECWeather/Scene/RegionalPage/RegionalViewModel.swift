//
//  RegionalViewModel.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/26.
//

import Foundation
import MapKit

class RegionalViewModel {
    func getCustomAnnotation(cityName: String, completion: @escaping (CustomAnnotation?) -> Void) {
        var location: CustomAnnotation?
        NetworkService.getCurrentWeather(cityName: cityName) { item in
            if let item = item {
                NetworkService.getIcon(iconCode: item.icon) { icon in
                    DispatchQueue.main.async {
                        location = CustomAnnotation(
                            title: cityName,
                            subtitle: "\(String(Int(item.minTemp))) / \(String(Int(item.maxTemp)))",
                            iconImage: UIImage(data: icon!),
                            coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon)
                        )
                        completion(location)
                    }
                }
            }
        }
    }

    func getMyLocationAnnotation(latitude: Double, longitude: Double, completion: @escaping (CustomAnnotation?) -> Void) {
        var location: CustomAnnotation?
        NetworkService.getCurrentWeather(lat: latitude, lon: longitude) { item in
            if let item = item {
                NetworkService.getIcon(iconCode: item.icon) { icon in
                    DispatchQueue.main.async {
                        location = CustomAnnotation(
                            title: "내 위치",
                            subtitle: "\(String(Int(item.minTemp))) / \(String(Int(item.maxTemp)))",
                            iconImage: UIImage(data: icon!),
                            coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon)
                        )
                        completion(location)
                    }
                }
            }
        }
    }
}
