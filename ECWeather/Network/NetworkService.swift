//
//  NetworkService.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import Alamofire
import Foundation

class NetworkService {
    static func getMyLocationWeather(lat: Double, lon: Double, completion: @escaping (CustomWeather?) -> Void) {
        let apiKey = "d800fe6a5ba7206df395b13ece10adee"
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        // API 요청 및 디코딩
        AF.request(apiUrl).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                if let weather = currentWeather.weather.first {
                    completion( CustomWeather(cloud: currentWeather.clouds.all, currentTemp: currentWeather.main.temp, maxTemp: currentWeather.main.tempMax, minTemp: currentWeather.main.tempMin, feelTemp: currentWeather.main.feelsLike, pressure: currentWeather.main.pressure, dt: currentWeather.dt, humidity: currentWeather.main.humidity, sunrise: currentWeather.sys.sunrise, sunset: currentWeather.sys.sunset, id: currentWeather.sys.id, descriotion: weather.description, icon: weather.icon, windSpeed: currentWeather.wind.speed, windDeg: currentWeather.wind.deg))
                }
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    static func getCurrentWeather(cityName: String, completion: @escaping (CustomWeather?) -> Void) {
        let apiKey = "d800fe6a5ba7206df395b13ece10adee"
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric"
        // API 요청 및 디코딩
        AF.request(apiUrl).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                if let weather = currentWeather.weather.first {
                    completion( CustomWeather(cloud: currentWeather.clouds.all, currentTemp: currentWeather.main.temp, maxTemp: currentWeather.main.tempMax, minTemp: currentWeather.main.tempMin, feelTemp: currentWeather.main.feelsLike, pressure: currentWeather.main.pressure, dt: currentWeather.dt, humidity: currentWeather.main.humidity, sunrise: currentWeather.sys.sunrise, sunset: currentWeather.sys.sunset, id: currentWeather.sys.id, descriotion: weather.description, icon: weather.icon, windSpeed: currentWeather.wind.speed, windDeg: currentWeather.wind.deg))
                }
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    static func getIcon(iconCode: String, completion: @escaping (Data?) -> Void) {
        let iconURLString = "https://openweathermap.org/img/w/\(iconCode).png"
        if let iconURL = URL(string: iconURLString) {
            // 이미지를 다운로드
            if let data = try? Data(contentsOf: iconURL) {
                completion(data)
            }
        }
        completion(nil)
    }
}
