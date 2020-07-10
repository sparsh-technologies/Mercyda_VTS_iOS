//
//  VehicleFlowModel.swift
//  MERCYDA TRACK
//
//  Created by test on 09/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import CoreLocation

class VehicleFlow  {
    
    // MARK: - Properties
    private let networkServiceCalls = NetworkServiceCalls()
    var packetsFiltered: [[DeviceDataResponse]] = []
    var processedResult: [TripDetailsModel] = []
    
}

extension VehicleFlow {
    
    func performFiltering(packets: [DeviceDataResponse])  {
        let gnssFixFilterArray = packets.filter({ $0.d?.gnss_fix == 1})
        var type = gnssFixFilterArray.first
        var temArray: [DeviceDataResponse] = []
        temArray.removeAll()
        packetsFiltered.removeAll()
        
        for (index, value) in gnssFixFilterArray.enumerated() {
            if value.d?.vehicle_mode == type?.d?.vehicle_mode {
                temArray.append(value)
            }
            else {
                if temArray.count > 1 {
                    packetsFiltered.append(temArray)
                }
                temArray.removeAll()
                temArray.append(value)
                type = value
            }
            
            if index == packets.count-1 {
                if temArray.count > 1 {
                    packetsFiltered.append(temArray)
                }
                temArray.removeAll()
            }
        }
        calculateDistance(packets: packetsFiltered)
    }
    
    func calculateDistance(packets: [[DeviceDataResponse]]) {
        var distanceFromCoordinates = Double()
        var distanceFromSpeed = Double()
        var maxDistance = Double()
        var totalDistanceFromPacket = Double()
        var mode = String()
        var tripDetails: [TripDetailsModel] = []
        var averageSpeed: Int = 0
        
        
        _ = packets.map({ eachPacket in
            totalDistanceFromPacket = 0.0
            mode = eachPacket.first?.d?.vehicle_mode ?? "Unknown"
            _ = eachPacket.map({ value in
                averageSpeed = averageSpeed + (value.d?.speed ?? 0)
            })
            for item in 0..<eachPacket.count-1 {
                let  packet1 = eachPacket[item]
                let packet2 = eachPacket[item + 1]
                distanceFromCoordinates = calculateDistanceFormCoordinates(packet1Lat: Double(packet1.d?.latitude ?? "0")!, packet2Lat: Double(packet2.d?.latitude ?? "0")!, packet1Lon: Double(packet1.d?.longitude ?? "0")!, packet2Lon:Double(packet2.d?.longitude ?? "0")!)
                let time = durationInSeconds(packet1Duration: Double(packet1.d?.source_date ?? 0), packet2Duration: Double(packet2.d?.source_date ?? 0))
                let distance = calculateDistanceFormSpeed(firstPktSpeed: Double(packet1.d?.speed ?? 0), secondPktSpeed: Double(packet2.d?.speed ?? 0), duration: durationInSeconds(packet1Duration: Double(packet1.d?.source_date ?? 0), packet2Duration: Double(packet2.d?.source_date ?? 0)), packet: packet1)
                
                distanceFromSpeed = time < 600 ? distance : 0
                maxDistance = distanceFromCoordinates > distanceFromSpeed ? distanceFromCoordinates: distanceFromSpeed
                if distance.isNaN {
                    
                }
                totalDistanceFromPacket = totalDistanceFromPacket + maxDistance
                //                print("\n\n\n Distance in each Set ", totalDistanceFromPacket)
                
            }
            let trip = TripDetailsModel.init(mode: mode, distance: String(totalDistanceFromPacket), startTime: "", avrgSpeed: String(averageSpeed / eachPacket.count), duration: "")
            tripDetails.append(trip)
        })
        print("\n\n\n Result Array ", tripDetails)
    }
    
    func calculateDistanceFormCoordinates(packet1Lat: Double, packet2Lat: Double, packet1Lon: Double, packet2Lon: Double) -> Double {
        //        Previous Location
        let prevlocation = CLLocation(latitude: packet1Lat, longitude: packet1Lon)
        
        //My current location
        let currentLocation = CLLocation(latitude: packet2Lat, longitude: packet2Lon)
        
        //Measuring my distance to second location (in km)
        let distance = prevlocation.distance(from: currentLocation) / 1000
        
        //Display the result in km
        //        print(distance)
        
        return distance
    }
    func calculateDistanceFormSpeed(firstPktSpeed: Double, secondPktSpeed: Double, duration: Double, packet: DeviceDataResponse) -> Double  {
        if firstPktSpeed == 0 && secondPktSpeed == 0 {
            
        }
        else {
            let avrgSpeed = (firstPktSpeed + secondPktSpeed) / 2
            let duration = duration / (60 * 60)
            let result = avrgSpeed / duration
            if result.isNaN {
                
            }
            return result
            
        }
        return 0
    }
    
    func durationInSeconds(packet1Duration: Double, packet2Duration: Double) -> Double {
        let pkt1Duration = Date(timeIntervalSince1970: (packet1Duration / 1000.0))
        let pkt2Duration = Date(timeIntervalSince1970: (packet2Duration / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:ss a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        //        print(dateFormatter.string(from: date))
        //        print(dateFormatter.string(from: date2))
        let timeInSeconds = pkt1Duration.timeIntervalSince(pkt2Duration)
        return timeInSeconds
    }
    
    func getDeviceData(completion: @escaping (WebServiceResult<[DeviceDataResponse], String>) -> Void) {
        self.networkServiceCalls.getDeviceData(serialNumber: "IRNS1309", enableSourceDate: "true", startTime: "1593628200000", endTime: "1593714600000") { [weak self] (state) in
            guard let this = self else {
                return
            }
            switch state {
            case .success(let result as [DeviceDataResponse]):
                //                completion(.success(result))
                this.performFiltering(packets: result)
            case .failure(let error):
                completion(.failure(error))
                printLog(error)
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
            }
        }
    }
    
}
