//
//  WeatherGateway.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

typealias FetchWeatherEntityGatewayCompletion = (_ weathers: Result<Weather>) -> Void

class WeatherGatewayImplementation {
    
    let apiWeatherGateway: ApiWeatherGateway
    
    init(apiWeatherGateway: ApiWeatherGateway) {
        self.apiWeatherGateway = apiWeatherGateway
    }
    
    func fetchWeather(query: WeatherQuery, cached: @escaping (Weather) -> Void, completion: @escaping FetchWeatherEntityGatewayCompletion) {
        self.apiWeatherGateway.fetchDailyWeather(query: query, cached: cached, completion: completion)
    }
    
}
