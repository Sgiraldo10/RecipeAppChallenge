//
//  LogModel.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright ÂŠ 2022 Cebollitas. All rights reserved.
//

import Foundation
import os

public struct LogModel {
    var level: LogLevel
    var data: Any?
    var message: String = ""
    var file: String = #file
    var line: Int = #line
    var function: String = #function

    public init(level: LogLevel, data: Any?, message: String = "", file: String = #file, line: Int = #line, function: String = #function) {
        self.level = level
        self.data = data
        self.message = message
        self.file = file
        self.line = line
        self.function = function
    }
}

public enum LogLevel: String {
    case debug = "[đ Debug]"
    case info = "[âšī¸ Information]"
    case error = "[âī¸ Error]"
    case fault = "[â ī¸ Fault]"
    case notice = "[đ Notice]"

    var value: OSLogType {
        switch self {
        case .debug: return .debug
        case .info: return .info
        case .error: return .error
        case .fault: return .fault
        case .notice: return .default
        }
    }
}
