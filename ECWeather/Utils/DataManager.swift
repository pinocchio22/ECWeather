//
//  DataManager.swift
//  ECWeather
//
//  Created by 김지은 on 2023/10/02.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    /// 온도 표시 0이면 C, 1이면 F
    var temperatureType = 0
    
    var latitude: Double?
    var longitude: Double?
    
    var searchKeyword: [String] = []
    
    func temperatureExpression(temperature: Float) -> Float {
        if temperatureType == 0 {
            return (temperature * 1.8) + 32
        } else {
            return (temperature - 32) * 5/9
        }
    }
    
    /// 알림 수신음 정의 - AlarmViewController, SelectNotificationSoundViewController 사용
    static let notificationSoundList: [String: String] = [
        "뭐지": "notification_sound_moji",
        "꽥": "notification_sound_quack",
        "탸댜아아ㅏ" : "notification_sound_taddddaaaaa",
        "오와우우으" : "notification_sound_wow",
    ]
}
