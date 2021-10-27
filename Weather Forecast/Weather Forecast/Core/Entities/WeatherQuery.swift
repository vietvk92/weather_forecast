//
//  WeatherQuery.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import Foundation

struct WeatherQuery: Equatable {
    let query: String
    let numberOfDay: Int = 7
    let units: String = "metric"
}
