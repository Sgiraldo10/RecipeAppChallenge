//
//  Date+Extension.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public extension Date {
    func readableFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current

        return formatter.string(from: self as Date)
    }
}
