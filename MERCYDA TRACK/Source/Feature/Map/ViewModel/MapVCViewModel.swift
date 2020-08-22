//
//  MapVCViewModel.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 08/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

protocol MapVCViewModelDelegate : class {
    func updateParkingLocationsOnMap(Locations locationsArray: [Latlon], Devices deviceArray: [D])
    func updateMovingLocationsOnMap(Locations locationsArray: [Latlon])
    func showError(errorMessage: String)
    func showLoader()
    func hideLoader()
}

class MapVCViewModel  {
    // MARK: - Properties
    let networkServiceCalls = NetworkServiceCalls()
    var originalDeviceList : [D]?
    var arrForMovingLocations:[Latlon] = []
    var arrForHaltAndStopLocations:[Latlon] = []
    weak var delegate : MapVCViewModelDelegate?
    
    required init(deviceList: [D]?) {
        self.originalDeviceList = deviceList
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
    
    func updateParkingMarkers() {
        if let array = self.originalDeviceList {
        if let sleepHaltArray = array.getSleepAndHaltDeviceArray() {
            self.arrForHaltAndStopLocations = sleepHaltArray.getCoordinates()
            delegate?.updateParkingLocationsOnMap(Locations: self.arrForHaltAndStopLocations, Devices: sleepHaltArray)
        }
        }
    }
    
    
    func getDeviceData() {
        delegate?.showLoader()
        self.networkServiceCalls.getDeviceData(serialNumber: "IRNS1309", enableSourceDate: "true", startTime: "1593628200000", endTime: "1593714600000") { (state) in
            self.delegate?.hideLoader()
            switch state {
            case .success(let result as [DeviceDataResponse]):
                self.originalDeviceList = result.getActiveDevicePackets()
            case .failure(let error):
                self.delegate?.showError(errorMessage: error)
                printLog(error)
            default:
                self.delegate?.showError(errorMessage: AppSpecificError.unknownError.rawValue)
            }
        }
    }
}
