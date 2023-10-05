//
//  WeeklyWeather.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/10/02.
//

import Foundation

// MARK: - WeeklyWeather
struct WeeklyWeather: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
    
    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
        
        struct Coord: Codable {
            let lat, lon: Double
        }
    }
    
    struct List: Codable {
        let dt: Int
        let main: MainClass
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
        }
        
        struct Clouds: Codable {
            let all: Int
        }
        
        struct MainClass: Codable {
            let temp, feelsLike, tempMin, tempMax: Double
            let pressure, seaLevel, grndLevel, humidity: Int
            let tempKf: Double

            enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure
                case seaLevel = "sea_level"
                case grndLevel = "grnd_level"
                case humidity
                case tempKf = "temp_kf"
            }
        }
        
        struct Sys: Codable {
            let pod: Pod
            
            enum Pod: String, Codable {
                case d = "d"
                case n = "n"
            }
        }
        
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Wind: Codable {
            let speed: Double
            let deg: Int
            let gust: Double
        }

    }
}

struct CustomWeeklyWeather {
    let currentTemp: Double
    let maxTemp: Double
    let minTemp: Double
    let feelTemp: Double
    var dateTime: String
    let humidity: Int
    let id: Int
    let description: String
    let icon: String
    
}
