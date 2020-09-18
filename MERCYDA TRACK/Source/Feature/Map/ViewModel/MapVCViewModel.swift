//
//  MapVCViewModel.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 08/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

protocol MapVCViewModelDelegate : class {
    func updateParkingLocationsOnMap(Locations locationsArray: [Latlon], Devices deviceArray: [TripDetailsModel])
    func updateMovingLocationsOnMap(Locations locationsArray: [Latlon])
    func updateSourceDateOfLastPacket(dateString : String)
    func updateDistance(distance : String)
    func updatePolyLines(Locations locationsArray: [Latlon])
    func updateCarLocationWhenNoMovingLocationFound(Locations locationsArray: [Latlon])
    func showError(errorMessage: String)
    func showLoader()
    func hideLoader()
}

class MapVCViewModel  {
    // MARK: - Properties
    let networkServiceCalls = NetworkServiceCalls()
    var originalDeviceList : [D]?
    var lastDevicePacket : D? {
        didSet {
            self.updateLastDate()
        }
    }
    var arrForMovingLocations:[Latlon] = []
    var arrForHaltAndStopLocations:[TripDetailsModel]?
    weak var delegate : MapVCViewModelDelegate?
    var serialNumber : String?
    weak var APItimer: Timer?
    private var totalDistance: Double = 0.00
    private var maximumSpeed: Double = 0.00
    private let vehicleFlowObj = VehicleFlow()
    
    var latestPackets : [D]? {
        didSet {
            self.lastDevicePacket = latestPackets?.first
            if let packets = latestPackets, packets.count > 0 {
                originalDeviceList?.append(contentsOf: packets)
                self.delegate?.updatePolyLines(Locations: packets.getCoordinates())
                if let pkts = originalDeviceList, pkts.count > 0 {
                    let uniqePackets = Utility.uniq(source: pkts)
                    self.delegate?.updateDistance(distance: "\(String(format: "%.2f",vehicleFlowObj.performFiltering(packets: uniqePackets, isPlaceAPI: false))) KM")
//                    let wrapperArray : [vehicleDataWrapper] = originalDeviceList?.compactMap {(vehicleDataWrapper.init(d: $0))} ?? []
//                    vehicleFlowObj.writePacketsToDB(deviceID: serialNumber ?? "", date: String(originalDeviceList?.first?.source_date ?? 0), devicePackets: wrapperArray)
                }
            }
        }
    }
    
    required init(deviceList: [D]?, serialNumber : String, parkingLocations: [TripDetailsModel]?, totalDistance: Double, maximumSpeed: Double) {
        self.originalDeviceList = deviceList
        self.lastDevicePacket = deviceList?.first
        self.serialNumber = serialNumber
        self.arrForHaltAndStopLocations = parkingLocations
        self.totalDistance = totalDistance
        self.maximumSpeed = maximumSpeed
    }

}

extension MapVCViewModel {
    
    func updateViewController() {
        guard let array = self.originalDeviceList else { return }
        
            let movingDeviceArray = array.getMovingPackets(); if movingDeviceArray.count > 0 {
                self.arrForMovingLocations = movingDeviceArray.getCoordinates()
                
                if totalDistance < 15.00  {
                    let ignitionArray = movingDeviceArray.filterIgnitionONPackets()
                    if ignitionArray.count > 0 && ignitionArray.contains(where: { $0.speed ?? 0 > 10 }) {
                       delegate?.updateMovingLocationsOnMap(Locations: self.arrForMovingLocations.reversed())
                    } else {
                        delegate?.updateCarLocationWhenNoMovingLocationFound(Locations: self.arrForMovingLocations.reversed())
                        self.totalDistance = 0.00
                    }
                } else {
                    delegate?.updateMovingLocationsOnMap(Locations: self.arrForMovingLocations.reversed())
                }
             
                
            } else if array.count > 0 {
                let locations = array.getCoordinates(); if locations.count > 0 {
                    delegate?.updateCarLocationWhenNoMovingLocationFound(Locations: locations.reversed())
                    self.totalDistance = 0.0
                }
            }
            /*
        } else if array.count > 0 {
            let locations = array.getCoordinates(); if locations.count > 0 {
                delegate?.updateCarLocationWhenNoMovingLocationFound(Locations: locations.reversed())
            }
        }
          */
        updateLastDate()
        delegate?.updateDistance(distance: "\(String(format: "%.2f",self.totalDistance)) KM")
    }
    func updateLastDate() {
       if let packet = self.lastDevicePacket {
            let dateString = Utility.getDate(unixdateinMilliSeconds:packet.source_date ?? 0)
            self.delegate?.updateSourceDateOfLastPacket(dateString: dateString)
        }
    }
    
    func startUpdateLocations() {
        self.APItimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(self.getLatestPackets), userInfo: nil, repeats: true)
    }
    func stopUpdateLocations() {
        self.APItimer?.invalidate()
    }
    
    @objc func getLatestPackets() {
        guard let startDate = lastDevicePacket?.source_date, let serialNumber = self.serialNumber else {
            return
        }
        self.networkServiceCalls.getDeviceData(serialNumber: serialNumber, enableSourceDate: "true", startTime: String(startDate), endTime: getTimeStampForAPI(flag: 2)) { [weak self] (state) in
            guard let this = self else {
                return
            }
            switch state {
            case .success(let result as [DeviceDataResponse]):
                this.latestPackets = result.getActiveDevicePackets()
            case .failure(let error):
                this.delegate?.showError(errorMessage: error)
            default:
                this.delegate?.showError(errorMessage: AppSpecificError.unknownError.rawValue)
            }
        }
        
    }
    
    func getTimeStampForAPI(flag: Int) -> String {
        
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "yyyy-MM-dd"
        let now = NSDate()
        let currentYear = startDateFormatter.string(from: now as Date)
        let dateString = "00:00:00 " + currentYear
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
    
    func updateParkingMarkers() {
        if let array = self.arrForHaltAndStopLocations {
            let locationCoordinates = array.getCoordinates()
            delegate?.updateParkingLocationsOnMap(Locations: locationCoordinates, Devices: array)
        }
    }
}
