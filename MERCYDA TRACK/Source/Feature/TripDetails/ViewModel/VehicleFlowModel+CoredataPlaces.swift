//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation
import CoreData

extension VehicleFlow {
    
    func writeAddressToDB(lat: Double, long: Double, address: String) {
        var isFound = false
        managedContext = appDelegate.coreDataStack.managedContext
        
        let fetchVehicles: NSFetchRequest<PlacesTable> = PlacesTable.fetchRequest()
        do{
            
            let results =  try managedContext.fetch(fetchVehicles)
            for item in results {
                if item.lat == lat.truncate(places: 2) && item.long == long.truncate(places: 2) {
                    isFound = true
                    item.setValue(address, forKey: "address")
                }
            }
            try managedContext.save()
        }
        catch let error as NSError {
            print("Update error: \(error) description: \(error.userInfo)")
        }
        
        if !isFound {
            
            do {
                let addressDB = PlacesTable(context: managedContext)
                addressDB.lat = lat
                addressDB.long = long
                addressDB.setValue(address, forKey: "address")
                try managedContext.save()
            }
            catch let error as NSError {
                print("Insert error in Coredata: \(error) description: \(error.userInfo)")
            }
        }
    }
    
    func fetchAddressFromDB(lat: Double, long: Double) -> String? {
        managedContext = appDelegate.coreDataStack.managedContext
        
        let fetchAddress: NSFetchRequest<PlacesTable> = PlacesTable.fetchRequest()
        do{
            
            let results =  try managedContext.fetch(fetchAddress)
            for item in results {
                if item.lat == lat && item.long == long {
                    return item.address ?? ""
                }
            }
            try managedContext.save()
        }
        catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
}
