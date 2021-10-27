//
//  DailyWeatherRequest.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

struct DailyWeatherRequest: ApiRequest {
    let query: ApiWeatherRequest
    var urlRequest: URLRequest {
        let baseURL: URL! = URL(string: "\(AppConfiguration.baseURL)/data/2.5/forecast/daily")
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "cnt", value: "\(query.cnt)"),
            URLQueryItem(name: "units", value: "\(query.units)"),
            URLQueryItem(name: "appid", value: AppConfiguration.appID),
            URLQueryItem(name: "q", value: "\(query.q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        return request
    }
}
