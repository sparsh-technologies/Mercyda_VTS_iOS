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
    func updatePolyLines(Locations locationsArray: [Latlon])
    func showError(errorMessage: String)
    func showLoader()
    func hideLoader()
}

class MapVCViewModel  {
    // MARK: - Properties
    let networkServiceCalls = NetworkServiceCalls()
    var originalDeviceList : [D]?
    var lastDevicePacket : D?
    var arrForMovingLocations:[Latlon] = []
    var arrForHaltAndStopLocations:[TripDetailsModel]?
    weak var delegate : MapVCViewModelDelegate?
    var serialNumber : String?
    weak var APItimer: Timer?
    
    var latestPackets : [D]? {
        didSet {
            self.lastDevicePacket = latestPackets?.first
            if let packets = latestPackets, packets.count > 0 {
                self.delegate?.updatePolyLines(Locations: packets.getCoordinates())
            }
        }
    }
    
    required init(deviceList: [D]?, serialNumber : String, parkingLocations: [TripDetailsModel]?) {
        self.originalDeviceList = deviceList
        self.lastDevicePacket = deviceList?.first
        self.serialNumber = serialNumber
        self.arrForHaltAndStopLocations = parkingLocations
    }
    
}

extension MapVCViewModel {
    
    func updateViewController() {
        if let array = self.originalDeviceList {
            let movingDeviceArray = array.getMovingPackets()
            self.arrForMovingLocations = movingDeviceArray.getCoordinates()
            delegate?.updateMovingLocationsOnMap(Locations: self.arrForMovingLocations.reversed())
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
      //  delegate?.showLoader()
        self.networkServiceCalls.getDeviceData(serialNumber: serialNumber, enableSourceDate: "true", startTime: String(startDate), endTime: getTimeStampForAPI(flag: 2)) { [weak self] (state) in
            guard let this = self else {
                return
            }
           // this.delegate?.hideLoader()
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
