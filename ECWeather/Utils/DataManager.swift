//
//  DataManager.swift
//  ECWeather
//
//  Created by 김지은 on 2023/10/02.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    /// 온도 표시 .celsius이면 C, .fahrenheit이면 F
    var temperatureType: Temperature = .celsius
    
    var latitude: Double?
    var longitude: Double?
    
    var searchKeyword: [String] = []
    
    var currentLocation = ""
    
    /// 알림 수신음 정의 - AlarmViewController, SelectNotificationSoundViewController 사용
    static let notificationSoundList: [String: String] = [
        "뭐지": "notification_sound_moji",
        "꽥": "notification_sound_quack",
        "탸댜아아ㅏ": "notification_sound_taddddaaaaa",
        "오와우우으": "notification_sound_wow",
    ]
    
    let locationList = ["Seoul", "Uijeongbu-si", "Namyangju", "chuncheon", "gangneung", "Bucheon-si", "Seongnam-si", "Cheongju-si", "Andong", "Daegu", "Jeonju", "Mokpo", "Changwon", "Busan", "Jeju-do"]
}
