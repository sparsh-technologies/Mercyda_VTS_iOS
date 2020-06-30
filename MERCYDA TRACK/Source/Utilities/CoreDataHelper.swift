//
//  CoreDataHelper.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//
import CoreData

/// Helper Class for Mange Coredata
@objcMembers final class CoreDataHelper: NSObject {
    
    /// Fetch Objects from Entity
    /// - Parameters:
    ///   - entityName: String Type
    ///   - managedObjectContext: ManagedObjectContext
    ///   - predicate: Predicate for Filter
    ///   - sortKey: String Type
    ///   - sortAscending: Bool
    ///   - withNoFaults: Bool
    static func getObjectsForEntity(_ entityName: String,
                                    andContext managedObjectContext: NSManagedObjectContext,
                                    withPredicate predicate: NSPredicate? = nil,
                                    withSortKey sortKey: String? = nil,
                                    isAscending sortAscending: Bool = false,
                                    withNoFaults: Bool = false) -> [NSManagedObject]? {

        let fetchRequest = self.fetchRequest(forEntity: entityName, withContext: managedObjectContext)
        fetchRequest.returnsObjectsAsFaults = withNoFaults
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        if let sortKey = sortKey {
            let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: sortAscending)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        do {
            guard let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            return result
        } catch _ as NSError {
            return nil
        }
    }
    
    /// Return object count
    /// - Parameters:
    ///   - entityName: String Type
    ///   - managedObjectContext:ManagedObjectContext
    ///   - predicate:Predicate for filter
    static func countForEntity(_ entityName: String,
                               andContext managedObjectContext: NSManagedObjectContext,
                               withPredicate predicate: NSPredicate? = nil) -> Int {

        let fetchRequest = self.fetchRequest(forEntity: entityName, withContext: managedObjectContext)
        fetchRequest.includesPropertyValues = false
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count
        } catch _ as NSError {
            return 0
        }
    }
    
    /// Remove all Objects from Entity
    /// - Parameters:
    ///   - entityName: String
    ///   - managedObjectContext: ManagedObjectContext
    ///   - predicate: Predicate for Filter
    static func deleteAllObjectsForEntity(_ entityName: String,
                                          andContext managedObjectContext: NSManagedObjectContext,
                                          withPredicate predicate: NSPredicate? = nil) {

        let fetchRequest = self.fetchRequest(forEntity: entityName, withContext: managedObjectContext)
        fetchRequest.includesPropertyValues = false
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        do {
            if let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                for managedObject in result {
                    managedObjectContext.delete(managedObject)
                }
            }
        } catch _ as NSError {
        }
    }
    
    /// Fetch data from Entity
    /// - Parameters:
    ///   - entityName: String
    ///   - context:ManagedObjectContext
    static private func fetchRequest(forEntity entityName: String,
                                     withContext context: NSManagedObjectContext) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
        fetchRequest.entity = entityDescription
        return fetchRequest
    }
}
