//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation
import CoreData

extension VehicleFlow {
    
    func writePacketsToDB(deviceID: String, date: String, devicePackets: [vehicleDataWrapper]) {
        replaceCurrentData(deviceID: deviceID, date: date, devicePackets: devicePackets)
    }
    
    func replaceCurrentData(deviceID: String, date: String, devicePackets: [vehicleDataWrapper])  {
        var isFound = false
        
        managedContext = appDelegate.coreDataStack.managedContext
        
        //            if results.count == 0 {
        //                let vehicleDataDB = VehicleData(context: managedContext)
        //                do {
        //                    vehicleDataDB.deviceNumber = deviceID
        //                    let packetsDB = PacketsData(context: managedContext)
        //                    packetsDB.date = date
        //                    packetsDB.setValue(devicePackets, forKey: "rawPackets")
        //                    vehicleDataDB.addToPacketsData(packetsDB)
        //                    try managedContext.save()
        //                }
        //                catch let error as NSError {
        //                    print("Insert error in Coredata: \(error) description: \(error.userInfo)")
        //                }
        //            }
        
        let fetchVehicles: NSFetchRequest<VehicleTable> = VehicleTable.fetchRequest()
        do{
            
            let results =  try managedContext.fetch(fetchVehicles)
            for item in results {
                if item.deviceID == deviceID && item.date == date {
                    isFound = true
                    item.setValue(devicePackets, forKey: "dPackets")
                }
            }
            try managedContext.save()
        }
        catch let error as NSError {
            print("Update error: \(error) description: \(error.userInfo)")
        }
        
        if !isFound {
            
            do {
                let vehicleDataDB = VehicleTable(context: managedContext)
                vehicleDataDB.deviceID = deviceID
                vehicleDataDB.date = date
                vehicleDataDB.setValue(devicePackets, forKey: "dPackets")
                try managedContext.save()
            }
            catch let error as NSError {
                print("Insert error in Coredata: \(error) description: \(error.userInfo)")
            }
        }
    }
    
    func fetchPacketsFromDB(deviceID: String, date: String) -> [D] {
        managedContext = appDelegate.coreDataStack.managedContext
        
        let fetchVehicles: NSFetchRequest<VehicleTable> = VehicleTable.fetchRequest()
        do{
            
            let results =  try managedContext.fetch(fetchVehicles)
            for item in results {
                if item.deviceID == deviceID && item.date == date {
                    if let vehicleArray = item.dPackets as? [vehicleDataWrapper] {
                        let dArray = vehicleArray.convertToDArray()
                        return dArray
                    }
                    
                }
            }
            try managedContext.save()
        }
        catch let error as NSError {
            print("Update error: \(error) description: \(error.userInfo)")
        }
        return []
        
        //
        //        do {
        //            let packetsFetch: NSFetchRequest<VehicleData> = VehicleData.fetchRequest()
        //            let results = try managedContext.fetch(packetsFetch)
        //            for value in results {
        //                /*
        //                 for res in value.deviceArray as! [NSObject] {
        //                 if let cast = res as? vehicleDataWrapper {
        //                 dump(cast)
        //                 }
        //                 }
        //                 */
        //                if value.deviceNumber == deviceID {
        //
        //                    for packets in value.packetsData as! Set<PacketsData> {
        //                        if packets.date == date {
        //                            if let vehicleArray = packets.rawPackets as? [vehicleDataWrapper] {
        //                                let dArray = vehicleArray.convertToDArray()
        //                                return dArray
        //                            }
        //                        }
        //
        //                    }
        //                }
        //            }
        //        }
        //        catch let error as NSError {
        //            print("Fetch error in Coredata: \(error) description: \(error.userInfo)")
        //        }
    }
    
}
