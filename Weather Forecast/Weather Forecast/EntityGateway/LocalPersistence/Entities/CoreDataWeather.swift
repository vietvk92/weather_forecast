//
//  CoreDataWeather.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import Foundation
import CoreData

extension WeatherResponseEntity {
    func toApiResponse() -> ApiWeatherResponse? {
        return .init(city: ApiWeatherResponse.City(id: id.hashValue, name: cityName ?? ""),
                     cnt: Int(cnt),
                     list: weathers?.allObjects.map {($0 as! WeatherDailyResponseEntity).toDailyWeather()} ?? [])
    }
}

extension WeatherDailyResponseEntity {
    func toDailyWeather() -> ApiWeatherResponse.ApiDailyWeather {
        let weatherTemparature = ApiWeatherResponse.ApiDailyWeather.Temparature(min: tempMin, max: tempMax)
        let weatherDetail = ApiWeatherResponse.ApiDailyWeather.WeatherDetail(id: Int(weatherId),
                                                                             main: weatherMain ?? "",
                                                                             description: weatherDescription ?? "",
                                                                             icon: weatherIcon ?? "")
        return .init(dt: Int(dt),
                     temp: weatherTemparature,
                     pressure: Int(pressure),
                     humidity: Int(humidity),
                     weather: [weatherDetail])
    }
}

extension ApiWeatherRequest {
    func toEntity(in context: NSManagedObjectContext) -> WeatherRequestEntity {
        let entity: WeatherRequestEntity = .init(context: context)
        entity.q = q
        entity.cnt = Int32(cnt)
        entity.units = units
        entity.createdAt = Date()
        return entity
    }
}

extension ApiWeatherResponse {
    func toEntity(in context: NSManagedObjectContext) -> WeatherResponseEntity {
        let entity: WeatherResponseEntity = .init(context: context)
        entity.cnt = Int32(cnt)
        entity.cityId = Int32(city.id)
        entity.cityName = city.name
        list.forEach {
            entity.addToWeathers($0.toEntity(in: context))
        }
        return entity
    }
}

extension ApiWeatherResponse.ApiDailyWeather {
    func toEntity(in context: NSManagedObjectContext) -> WeatherDailyResponseEntity {
        let entity: WeatherDailyResponseEntity = .init(context: context)
        entity.dt = Double(dt)
        entity.humidity = Int32(humidity)
        entity.pressure = Int32(pressure)
        entity.tempMax = temp.max
        entity.tempMin = temp.min
        entity.weatherDescription = weather.first?.description
        entity.weatherIcon = weather.first?.icon
        entity.weatherMain = weather.first?.main
        return entity
    }
}
