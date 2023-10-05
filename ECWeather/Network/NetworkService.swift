//
//  NetworkService.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import Alamofire
import Foundation

class NetworkService {
    static func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (CustomWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&\(DataManager.shared.temperatureType.rawValue)&lang=kr"
        // API 요청 및 디코딩
        AF.request(apiUrl).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                if let weather = currentWeather.weather.first {
                    completion(CustomWeather(lat: currentWeather.coord.lat, lon: currentWeather.coord.lon, currentTemp: currentWeather.main.temp, maxTemp: currentWeather.main.tempMax, minTemp: currentWeather.main.tempMin, feelTemp: currentWeather.main.feelsLike, dt: currentWeather.dt, humidity: currentWeather.main.humidity, sunrise: currentWeather.sys.sunrise, sunset: currentWeather.sys.sunset, id: currentWeather.id,mainDescription: weather.main, description: weather.description, icon: weather.icon, windSpeed: currentWeather.wind.speed, name: currentWeather.name))
                }
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    static func getCurrentWeather(cityName: String, completion: @escaping (CustomWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(Key.apiKey.rawValue)&\(DataManager.shared.temperatureType.rawValue)&lang=kr"
        // API 요청 및 디코딩
        AF.request(apiUrl).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                if let weather = currentWeather.weather.first {
                    completion(CustomWeather(lat: currentWeather.coord.lat, lon: currentWeather.coord.lon, currentTemp: currentWeather.main.temp, maxTemp: currentWeather.main.tempMax, minTemp: currentWeather.main.tempMin, feelTemp: currentWeather.main.feelsLike, dt: currentWeather.dt, humidity: currentWeather.main.humidity, sunrise: currentWeather.sys.sunrise, sunset: currentWeather.sys.sunset, id: currentWeather.id,mainDescription: weather.main, description: weather.description, icon: weather.icon, windSpeed: currentWeather.wind.speed, name: currentWeather.name))
                }
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    static func getWeeklyWeather(cityName: String, completion: @escaping ([CustomWeeklyWeather]?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(Key.apiKey.rawValue)&\(DataManager.shared.temperatureType.rawValue)&lang=kr"
        
        var weatherList = [CustomWeeklyWeather]()
        // API 요청 및 디코딩
        AF.request(apiUrl).responseDecodable(of: WeeklyWeather.self) { response in
            switch response.result {
            case .success(let weeklyWeather):
                weeklyWeather.list.forEach { item in
                    if let weather = item.weather.first {
                        weatherList.append(CustomWeeklyWeather(currentTemp: item.main.temp, maxTemp: item.main.tempMax, minTemp: item.main.tempMin, feelTemp: item.main.feelsLike, dateTime: item.dtTxt, humidity: item.main.humidity, id: weather.id, description: weather.description, icon: weather.icon))
                    }
                }
                completion(weatherList)
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    static func getWeeklyWeather(lat: Double, lon: Double, completion: @escaping ([CustomWeeklyWeather]?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&\(DataManager.shared.temperatureType.rawValue)&lang=kr"
        
        var weatherList = [CustomWeeklyWeather]()
        // API 요청 및 디코딩
        AF.request(apiUrl).responseDecodable(of: WeeklyWeather.self) { response in
            switch response.result {
            case .success(let weeklyWeather):
                weeklyWeather.list.forEach { item in
                    if let weather = item.weather.first {
                        weatherList.append(CustomWeeklyWeather(currentTemp: item.main.temp, maxTemp: item.main.tempMax, minTemp: item.main.tempMin, feelTemp: item.main.feelsLike, dateTime: item.dtTxt, humidity: item.main.humidity, id: weather.id, description: weather.description, icon: weather.icon))
                    }
                }
                completion(weatherList)
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    static func getIcon(iconCode: String, completion: @escaping (Data?) -> Void ) {
        let iconURLString = "https://openweathermap.org/img/w/\(iconCode).png"
        DispatchQueue.global().async {
            if let iconURL = URL(string: iconURLString) {
                // 이미지를 다운로드
                if let data = try? Data(contentsOf: iconURL) {
                     completion(data)
                } else {
                    completion(nil)
                }
            }
        } 
    }
}
