//
//  Weather.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    // 구름 양
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    // 경도, 위도
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    let seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    // type, id, 국가코드, 일출시간, 일몰시간
    let type, id: Int?
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    // id, 주요 키워드, 상세 키워드, 아이콘
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    // 풍속, 풍향, 돌풍
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct CustomWeather {
    let lat: Double
    let lon: Double
    let cloud: Int
    let currentTemp: Double
    let maxTemp: Double
    let minTemp: Double
    let feelTemp: Double
    let pressure: Int
    var dt: Int
    var dataTimestamp: String {
        let dataDate = Date(timeIntervalSince1970: Double(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter.string(from: dataDate)
    }
    let humidity: Int
    var sunrise: Int
    var sunriseTimestamp: String {
        let sunriseDate = Date(timeIntervalSince1970: Double(sunrise))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter.string(from: sunriseDate)
    }
    var sunset: Int
    var sunsetTimestamp: String {
        let sunsetDate = Date(timeIntervalSince1970: Double(sunset))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter.string(from: sunsetDate)
    }
    let id: Int
    let descriotion: String
    let icon: String
    let windSpeed: Double
    let windDeg: Int
}
