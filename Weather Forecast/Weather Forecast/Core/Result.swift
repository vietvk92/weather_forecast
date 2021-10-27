//
//  Result.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

typealias Result<T> = Swift.Result<T, ApiError>

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    var message = String.defaultMessageError
}
