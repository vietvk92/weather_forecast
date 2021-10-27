//
//  ApiClient.swift
//  Weather Forecast
//
//  Created by Thu Hien on 23/10/2021.
//

import Foundation

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest, completion: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImplementation: ApiClient {
    
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    // MARK: - ApiClient
    func execute<T>(request: ApiRequest, completion: @escaping (Result<ApiResponse<T>>) -> Void) {
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completion(.failure(ApiError(data: nil, error: error, httpUrlResponse: nil)))
                return
            }
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                    completion(.success(response))
                } catch {
                    completion(.failure(ApiError(data: nil,
                                                 error: error,
                                                 httpUrlResponse: httpUrlResponse)))
                }
            } else {
                completion(.failure(ApiError(data: data,
                                                    error: error,
                                                    httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
}
