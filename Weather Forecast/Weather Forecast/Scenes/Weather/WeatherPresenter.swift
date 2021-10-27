//
//  WeatherPresenter.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import Foundation

protocol WeatherView: AnyObject {
    func displayWeather()
    func display(error: String)
    func showLoading()
    func hiddenLoading()
}

protocol WeatherPresenter {
    
    var numberOfDays: Int { get }
    
    func showInvalidInput()
    func weather(day: Int) -> DailyWeather
    func fetchDailyWeather(with query: WeatherQuery)
}

class WeatherPresenterImplementation: WeatherPresenter {
    
    private weak var view: WeatherView?
    private let searchDailyWeatherUseCase: SearchWeatherUserCase
    
    var weatherList: [DailyWeather] = []
    
    var numberOfDays: Int {
        return weatherList.count
    }
    
    init(view: WeatherView, searchDailyWeather: SearchWeatherUserCase) {
        self.view = view
        self.searchDailyWeatherUseCase = searchDailyWeather
    }
    
    func fetchDailyWeather(with query: WeatherQuery) {
        view?.showLoading()
        self.searchDailyWeatherUseCase.search(param: .init(query: query)) {
            [weak self] weatherInfo in
            self?.view?.hiddenLoading()
            self?.weatherList = weatherInfo.list
            self?.view?.displayWeather()
        } completion: { [weak self] result in
            self?.view?.hiddenLoading()
            switch result {
            case .success(let weather):
                self?.weatherList = weather.list
                self?.view?.displayWeather()
            case .failure(let error):
                self?.weatherList = []
                self?.view?.display(error: error.localizedDescription)
            }
        }
    }

    func weather(day: Int) -> DailyWeather {
        return self.weatherList[day]
    }
    
    func showInvalidInput() {
        view?.display(error: String.invalidInputError)
    }
}
