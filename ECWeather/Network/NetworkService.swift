//
//  NetworkService.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import Alamofire
import Foundation

class NetworkService {
    static func getCurrentWeather(cityName: String) {
        let apiKey = "d800fe6a5ba7206df395b13ece10adee"
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric"
        // API 요청 및 디코딩
        AF.request(apiUrl).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                print("현재 날씨 정보: \(currentWeather)")
                // 여기에서 원하는 데이터를 처리하세요.
            case .failure(let error):
                print("API 요청 실패: \(error)")
            }
        }
    }
    
    static func getIcon(iconCode: String) {
        let iconURLString = "https://openweathermap.org/img/w/\(iconCode).png"
        if let iconURL = URL(string: iconURLString) {
            // 이미지를 다운로드
            if let data = try? Data(contentsOf: iconURL) {
//                    UIImage(data: data)
            }
        }
    }
}
