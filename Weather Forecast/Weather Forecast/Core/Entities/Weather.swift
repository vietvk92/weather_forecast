//
//  Weather.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

struct Weather: Identifiable {
    
    typealias Identifier = Int
    
    let id: Identifier
    let list: [DailyWeather]
}

struct DailyWeather {
    var date: Int?
    var avgTemparature: Int?
    var pressure: Int?
    var humidity: Int?
    var description: String?
    var iconUrl: URL?
}
