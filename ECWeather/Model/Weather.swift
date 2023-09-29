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
    // 온도, 체감온도, 최저, 최고
    let temp, feelsLike, tempMin, tempMax: Double
    // 기압, 습도
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    // type, id, 국가코드, 일출시간, 일몰시간
    let type, id: Int
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
