//
//  NSManagedObjectContext+Extension.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    /// Coredata Insert
    /// - Parameter type: Generic Type
  public func insert<T: NSManagedObject>(_ type: T.Type) -> T? {
    let entityName = T.description()
    let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: self)
    return entity as? T
  }
}
