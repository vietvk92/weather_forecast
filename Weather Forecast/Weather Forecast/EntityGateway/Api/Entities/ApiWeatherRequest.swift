//
//  ApiWeatherRequest.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import Foundation

struct ApiWeatherRequest: Encodable {
    let q: String
    let cnt: Int
    let units: String
}
