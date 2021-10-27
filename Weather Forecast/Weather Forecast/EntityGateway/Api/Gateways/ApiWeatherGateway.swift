//
//  ApiWeatherGateway.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

protocol ApiWeatherGateway {
    func fetchDailyWeather(query: WeatherQuery,
                           cached: @escaping (Weather) -> Void,
                           completion: @escaping FetchWeatherEntityGatewayCompletion)
}

class ApiWeatherGatewayImplementation: ApiWeatherGateway {
    
    private let apiClient: ApiClient
    private let cache: LocalPersistenceWeatherGateway
    init(apiClient: ApiClient, cache: LocalPersistenceWeatherGateway) {
        self.apiClient = apiClient
        self.cache = cache
    }
    
    func fetchDailyWeather(query: WeatherQuery, cached: @escaping (Weather) -> Void, completion: @escaping FetchWeatherEntityGatewayCompletion) {
        let weatherRequest = ApiWeatherRequest(q: query.query, cnt: query.numberOfDay, units: query.units)
        cache.fetchResponse(for: weatherRequest) { result in
            if case let .success(response?) = result {
                cached(response.toCore())
            } else {
                let weatherApiRequest = DailyWeatherRequest(query: weatherRequest)
                self.apiClient.execute(request: weatherApiRequest) { (result: Result<ApiResponse<ApiWeatherResponse>>) in
                    switch result {
                    case let .success(response):
                        self.cache.save(weatherResponse: response.entity, for: weatherRequest)
                        completion(.success(response.entity.toCore()))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
