//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation
import CoreData

extension VehicleFlow {
    
    func addProductsToDB(deviceID: String, date: String, rawPackets: [vehicleDataWrapper]) {
        
        managedContext = appDelegate.coreDataStack.managedContext
        
        
        let vehicleDataDB = VehicleData(context: managedContext)
        let packetsDB = PacketsData(context: managedContext)
        
        do {
            
            vehicleDataDB.deviceNumber = "Test device number32"
            vehicleDataDB.setValue(rawPackets, forKey: "deviceArray")
            //vehicleDataDB.deviceArray = rawPackets as NSObject
            packetsDB.date = "today23"
            packetsDB.setValue(rawPackets, forKey: "rawPackets")
            
            try managedContext.save()
            fetchData()
            
        }
        catch let error as NSError {
            print("Insert error in Coredata: \(error) description: \(error.userInfo)")
        }
    }
    
    func fetchData() {
        do {
            let productsFetch: NSFetchRequest<VehicleData> = VehicleData.fetchRequest()
            let results = try managedContext.fetch(productsFetch)
            for value in results {
                /*
                for res in value.deviceArray as! [NSObject] {
                    if let cast = res as? vehicleDataWrapper {
                        dump(cast)
                    }
                }
                */
                if let vehicleArray = value.deviceArray as? [vehicleDataWrapper] {
                    let dArray = vehicleArray.convertToDArray()
                    print(dArray.count)
                }
                
                
            }
        }
        catch let error as NSError {
            print("Insert error in Coredata: \(error) description: \(error.userInfo)")
        }
        
    }
    
}
