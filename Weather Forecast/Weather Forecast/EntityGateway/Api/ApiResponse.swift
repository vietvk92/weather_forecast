//
//  ApiResponse.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

struct ApiError: Error {
    
    static let code = 999

    let data: Data?
    let error: Error?
    let httpUrlResponse: HTTPURLResponse?

    let defaultMessage = "Something went wrong, please try again!"

    var localizedDescription: String {
        guard let response = httpUrlResponse else {
            return (error?.localizedDescription) ?? defaultMessage
        }
        switch response.statusCode {
        case 404:
            return "Oops! No data found!"
        default:
            return defaultMessage
        }
    }
}

struct ApiResponse<T: Decodable> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            let decoder = JSONDecoder()
            self.entity = try decoder.decode(T.self, from: data ?? Data())
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiError(data: data, error: error, httpUrlResponse: httpUrlResponse)
        }
    }
}
