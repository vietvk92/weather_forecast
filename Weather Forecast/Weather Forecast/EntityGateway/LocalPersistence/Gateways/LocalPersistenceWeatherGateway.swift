//
//  LocalPersistenceWeatherGateway.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import Foundation
import CoreData

typealias FetchApiWeatherResponseGatewayCompletion = (_ weathers: Result<ApiWeatherResponse?>) -> Void

protocol LocalPersistenceWeatherGateway {
    func save(weatherResponse: ApiWeatherResponse, for request: ApiWeatherRequest)
    func fetchResponse(for request: ApiWeatherRequest, completion: @escaping FetchApiWeatherResponseGatewayCompletion)
}

class CoreDataWeatherGateway: LocalPersistenceWeatherGateway {

    private let coreDataStack: CoreDataStackImplementation

    init(coreData: CoreDataStackImplementation = CoreDataStackImplementation.sharedInstance) {
        self.coreDataStack = coreData
    }

    private func fetchRequest(for requestWeather: ApiWeatherRequest) -> NSFetchRequest<WeatherRequestEntity> {
        let request: NSFetchRequest = WeatherRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d AND %K = %@",
                                        #keyPath(WeatherRequestEntity.q), requestWeather.q,
                                        #keyPath(WeatherRequestEntity.cnt), requestWeather.cnt,
                                        #keyPath(WeatherRequestEntity.units), requestWeather.units)
        return request
    }

    private func deleteResponse(for requestWeather: ApiWeatherRequest, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestWeather)
        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }

    func save(weatherResponse: ApiWeatherResponse, for request: ApiWeatherRequest) {
        do {
            let context = self.coreDataStack.persistentContainer.viewContext
            self.deleteResponse(for: request, in: context)
            let requestEntity = request.toEntity(in: context)
            requestEntity.response = weatherResponse.toEntity(in: context)
            try context.save()
        } catch {}
    }
    
    func fetchResponse(for request: ApiWeatherRequest, completion: @escaping FetchApiWeatherResponseGatewayCompletion) {
        do {
            let context = self.coreDataStack.persistentContainer.viewContext
            let fetchRequest = self.fetchRequest(for: request)
            let requestEntity = try context.fetch(fetchRequest).first

            completion(.success(requestEntity?.response?.toApiResponse()))
        } catch {
            completion(.failure(ApiError(data: nil,
                                         error: CoreError(message: "Failed retrieving requests the core data."),
                                         httpUrlResponse: nil)))
        }
    }

}
