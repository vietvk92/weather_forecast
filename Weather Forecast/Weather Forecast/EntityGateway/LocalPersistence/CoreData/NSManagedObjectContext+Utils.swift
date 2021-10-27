//
//  NSManagedObjectContext+Utils.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import Foundation
import CoreData
/*
protocol NSManagedObjectContextProtocol {
    func save() throws
    func addEntity<T: NSManagedObject>(withType type : T.Type) -> T?
    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T]
    func allEntities<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T]
    func deleteEntity<T: NSManagedObject>(withType type : T.Type, predicate: NSPredicate?)
}

extension NSManagedObjectContext: NSManagedObjectContextProtocol {

    func addEntity<T : NSManagedObject>(withType type: T.Type) -> T? {
        let entityName = T.description()
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self) else {
            return nil
        }
        let record = T(entity: entity, insertInto: self)
        return record
    }
    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T] {
        return try allEntities(withType: type, predicate: nil)
    }
    
    func allEntities<T : NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: T.description())
        request.predicate = predicate
        let results = try self.fetch(request)
        return results
    }
    
    func deleteEntity<T>(withType type: T.Type, predicate: NSPredicate?) where T : NSManagedObject {
        let request = NSFetchRequest<T>(entityName: T.description())
        request.predicate = predicate
        do {
            if let result = try self.fetch(request).first {
                self.delete(result)
            }
        } catch {
            print(error)
        }
    }
}
*/
