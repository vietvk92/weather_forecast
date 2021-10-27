//
//  ApiWeatherResponse.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

struct ApiWeatherResponse: Decodable {
    let city: City
    let cnt: Int
    var list: [ApiDailyWeather]
}

extension ApiWeatherResponse {
    
    struct City: Decodable {
        let id: Int
        let name: String
    }
    
    struct ApiDailyWeather: Decodable {
        
        struct Temparature: Decodable {
            var min: Double
            var max: Double
        }
        
        struct WeatherDetail: Decodable {
            var id: Int
            var main: String
            var description: String
            var icon: String
        }

        var dt: Int
        var temp: Temparature
        var pressure: Int
        var humidity: Int
        var weather: [WeatherDetail]
        
    }
}

// Mapping to core entity
extension ApiWeatherResponse {
    func toCore() -> Weather {
        return .init(id: city.id, list: list.map {$0.toCore()})
    }
}

extension ApiWeatherResponse.ApiDailyWeather {
    func toCore() -> DailyWeather {
        let weatherIcon = weather.first?.icon
        let iconUrl = URL(string: "\(AppConfiguration.baseURL)/img/w/\(weatherIcon ?? "").png")
        let averageTemp = ((temp.min + temp.max) / 2).rounded()
        return .init(date: dt, avgTemparature: Int(averageTemp), pressure: pressure, humidity: humidity, description: weather.first?.description, iconUrl: iconUrl)
    }
}
