//
//  DisplayDailyWeather.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

typealias SearchWeatherCompletion = (_ dailyWeather: Result<Weather>) -> Void

protocol SearchWeatherUserCase {
    func search(param: SearchWeatherUseCaseRequest, cached: @escaping (Weather) -> Void, completion: @escaping SearchWeatherCompletion)
}

class SearchWeatherUseCaseImplementation: SearchWeatherUserCase {
    
    let weatherGateway: WeatherGatewayImplementation
    
    init(weatherGateway: WeatherGatewayImplementation) {
        self.weatherGateway = weatherGateway
    }
    
    func search(param: SearchWeatherUseCaseRequest, cached: @escaping (Weather) -> Void, completion: @escaping SearchWeatherCompletion) {
        return self.weatherGateway.fetchWeather(query: param.query, cached: cached) { result in
            completion(result)
        }
    }
}

struct SearchWeatherUseCaseRequest {
    let query: WeatherQuery
}
