//
//  Integer+Extension.swift
//  Weather Forecast
//
//  Created by Thu Hien on 25/10/2021.
//

import Foundation

extension Int {
    func convertToFormat() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "E, dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}
