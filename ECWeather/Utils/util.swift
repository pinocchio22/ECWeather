//
//  Util.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import Foundation
import os.log

struct Util {
    static func print(output: Any = "", function: String = #function, file: String = #file, line: Int = #line) {
        var filename: NSString = file as NSString
        filename = filename.lastPathComponent as NSString
        
        DispatchQueue.main.async {
            let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Petmily")
            if #available(iOS 12.0, *) {
                if let output = output as? CVarArg {
                    os_log(.default, log: log,"%@ ----- %i Line ----- %@ %@", filename,line,function,output)
                }
            } else {
                Swift.print("\(filename) ----- \(line) Line ----- \(function) ----- \(output)")
            }
        }
    }
}
