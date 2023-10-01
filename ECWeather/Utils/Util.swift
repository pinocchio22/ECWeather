//
//  Util.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import os.log
import UIKit

struct Util {
    static func print(output: Any = "", function: String = #function, file: String = #file, line: Int = #line) {
        var filename: NSString = file as NSString
        filename = filename.lastPathComponent as NSString

        DispatchQueue.main.async {
            let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "ECWeather")
            if #available(iOS 12.0, *) {
                if let output = output as? CVarArg {
                    os_log(.default, log: log, "%@ ----- %i Line ----- %@ %@", filename, line, function, output)
                }
            } else {
                Swift.print("\(filename) ----- \(line) Line ----- \(function) ----- \(output)")
            }
        }
    }
}

enum Region: String {
    case seoul = "서울"
    case gwanak = "관악"
    case uijeongbu = "의정부"
    case namyangju = "남양주"
    case chuncheon = "춘천"
    case gangneung = "강릉"
    case bucheon = "부천"
    case bundang = "분당"
    case cheongju = "청주"
    case andong = "안동"
    case daegu = "대구"
    case jeonju = "전주"
    case mokpo = "목포"
    case yeosu = "여수"
    case changwon = "창원"
    case busan = "부산"
    case jeju = "제주"
}
