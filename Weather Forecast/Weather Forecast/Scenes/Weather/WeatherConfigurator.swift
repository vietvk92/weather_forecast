//
//  WeatherConfigurator.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import Foundation

protocol WeatherConfigurator {
    func  configure(weatherViewController: WeatherViewController)
}

class WeatherConfiguratorImplementation: WeatherConfigurator {
    func configure(weatherViewController: WeatherViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: .default, completionHandlerQueue: .main)
        let coreDataWeatherGateway = CoreDataWeatherGateway()
        let apiWeatherGateway = ApiWeatherGatewayImplementation(apiClient: apiClient, cache: coreDataWeatherGateway)
        let weatherGateway = WeatherGatewayImplementation(apiWeatherGateway: apiWeatherGateway)
        let searchWeatherUseCase = SearchWeatherUseCaseImplementation(weatherGateway: weatherGateway)
        let presenter = WeatherPresenterImplementation(view: weatherViewController, searchDailyWeather: searchWeatherUseCase)
        weatherViewController.presenter = presenter
    }
}
