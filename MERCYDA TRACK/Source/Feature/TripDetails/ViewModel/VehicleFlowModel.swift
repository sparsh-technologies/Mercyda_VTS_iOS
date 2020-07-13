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
    
   
    
    
    weak var delegate: VehicleFlowControllerDelegate?
    
    
}
extension VehicleFlow {
    
    /// Return Number of Sections for UITableView
    var numberOfSections: Int {
        return 1
    }
    
    /// Return Number of Rows in Sections for UITableView
    /// - Parameter section: Int Value
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.processedResult.count
    }
    
    func dataPointForIndex(index: Int) -> TripDetailsModel {
        return TripDetailsModel.init(mode: processedResult[index].vehicleMode, distance: processedResult[index].distance, startTime: processedResult[index].startTime, avrgSpeed: processedResult[index].averageSpeed, duration: processedResult[index].duration)
    }
}

extension VehicleFlow {
    
    func performFiltering(packets: [DeviceDataResponse])  {
        let gnssFixFilterArray = packets.getActiveDevicePackets()
        let twoDimArray = gnssFixFilterArray.get2DimensionalFilterArray()
        let singleDimensionArray = Array(twoDimArray.joined())
        let filteredTwoDimArray = singleDimensionArray.get2DimensionalFilterArray()
        calculateDistance(packets: filteredTwoDimArray)
    }
    
    func calculateDistance(packets: [[D]]) {
        var distanceFromCoordinates = Double()
        var distanceFromSpeed = Double()
        var maxDistance = Double()
        var totalDistanceFromPacket = Double()
        var mode = String()
        var tripDetails: [TripDetailsModel] = []
        var averageSpeed: Int = 0
        var totalDistance = Double()
        
        
        
        packets.forEach({ eachPacket in
            totalDistanceFromPacket = 0.0
            averageSpeed = 0
            mode = eachPacket.first?.vehicle_mode ?? "Unknown"
            eachPacket.forEach({ value in
                averageSpeed = averageSpeed + (value.speed ?? 0)
            })
            for index in 0..<eachPacket.count - 1{
                let packet1 = eachPacket[index]
                let packet2 = eachPacket[index + 1]
                distanceFromCoordinates = calculateDistanceFormCoordinates(packet1Lat: Double(packet1.latitude ?? "0")!, packet2Lat: Double(packet2.latitude ?? "0")!, packet1Lon: Double(packet1.longitude ?? "0")!, packet2Lon:Double(packet2.longitude ?? "0")!)
                let time = durationInSeconds(packet1Duration: Double(packet1.source_date ?? 0), packet2Duration: Double(packet2.source_date ?? 0))
                let distance = calculateDistanceFormSpeed(firstPktSpeed: Double(packet1.speed ?? 0), secondPktSpeed: Double(packet2.speed ?? 0), duration: durationInSeconds(packet1Duration: Double(packet1.source_date ?? 0), packet2Duration: Double(packet2.source_date ?? 0)))
                
                distanceFromSpeed = time < 600 ? distance : 0
                maxDistance = distanceFromCoordinates > distanceFromSpeed ? distanceFromCoordinates: distanceFromSpeed
                if distance.isNaN {
                    
                }
                //                print("\n Coordinates ", distanceFromCoordinates)
                //                print("Speed ", distanceFromSpeed)
                //                print("Highest Distance ", maxDistance)
                totalDistanceFromPacket = totalDistanceFromPacket + distanceFromCoordinates
                //                print("\n\n\n Distance in each Set ", totalDistanceFromPacket)
                //                print("Total Distanec ", totalDistanceFromPacket)
            }
            let trip = TripDetailsModel.init(mode: mode, distance: String(totalDistanceFromPacket.truncate(places: 2)), startTime: milliSecondsToTime(milliSeconds: Double(eachPacket.first?.source_date ?? 0)), avrgSpeed: String(averageSpeed / eachPacket.count), duration: durationInEachPacketSet(startDuration: Double(eachPacket.first?.source_date ?? 0) , endDuration: Double(eachPacket.last?.source_date ?? 0)))
            tripDetails.append(trip)
            totalDistance = totalDistance + totalDistanceFromPacket
        })
        //        print("\n\n\n Result Array ", tripDetails)
        processedResult = tripDetails
        self.delegate?.loadData(vm: tripDetails)
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
    func calculateDistanceFormSpeed(firstPktSpeed: Double, secondPktSpeed: Double, duration: Double) -> Double  {
        if firstPktSpeed == 0 && secondPktSpeed == 0 {
            
        }
        else {
            let avrgSpeed = (firstPktSpeed + secondPktSpeed) / 2
            let duration = duration / (60 * 60)
            let result = avrgSpeed * duration
            return result
            
        }
        return 0
    }
    
    func milliSecondsToTime(milliSeconds: Double) -> String {
        let date = NSDate(timeIntervalSince1970: milliSeconds / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        //        print(dateFormatter.string(from: date as Date))
        return dateFormatter.string(from: date as Date)
    }
    
    func durationInSeconds(packet1Duration: Double, packet2Duration: Double) -> Double {
        if packet1Duration == 0 || packet2Duration == 0 {
            
        }
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
    func durationInEachPacketSet(startDuration: Double, endDuration: Double) -> DateComponents {
        if startDuration == 0 || endDuration == 0 {
            
        }
        let startDate = Date(timeIntervalSince1970: (endDuration / 1000.0))
        let endDate = Date(timeIntervalSince1970: (startDuration / 1000.0))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:ss a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        let cal = Calendar.current
        let components = cal.dateComponents([.hour, .minute , .second ], from: startDate, to: endDate)
        let diff = components
        //        print("******DATE******* \n", diff)
        return diff
    }
    
    func getDeviceData(serialNO: String, completion: @escaping (WebServiceResult<[DeviceDataResponse], String>) -> Void) {
        self.networkServiceCalls.getDeviceData(serialNumber: serialNO, enableSourceDate: "true", startTime: getTimeStampForAPI(flag: 1), endTime: getTimeStampForAPI(flag: 2)) { [weak self] (state) in
            guard let this = self else {
                return
            }
            switch state {
            case .success(let result as [DeviceDataResponse]):
                completion(.success(result))
                this.performFiltering(packets: result)
            case .failure(let error):
                completion(.failure(error))
                printLog(error)
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
            }
        }
    }
    func getTimeStampForAPI(flag: Int) -> String {
        
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "yyyy-MM-dd"
        let now = NSDate()
        let currentYear = startDateFormatter.string(from: now as Date)
        let dateString = "00:01:00 " + currentYear
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss yyyy-MM-dd"
        let s = dateFormatter.date(from: dateString)
        let startDate = s!.timeIntervalSince1970 * 1000
        let endDate = NSDate().timeIntervalSince1970 * 1000
        
        if flag == 1 {
            return String(Int(startDate))
        }
        if flag == 2 {
            return String(Int(endDate))
        }
        return ""
    }
    
}
