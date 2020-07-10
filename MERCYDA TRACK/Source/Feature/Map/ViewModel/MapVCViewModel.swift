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
    private let networkServiceCalls = NetworkServiceCalls()
    var originalDeviceList : [D]? {
        didSet {
            if let array = self.originalDeviceList {
                if let sleepHaltArray = self.makeSleepAndHaltDeviceArray(array) {
                    self.arrForHaltAndStopLocations = self.getCoordinates(sleepHaltArray)
                    delegate?.updateParkingLocationsOnMap(Locations: self.arrForHaltAndStopLocations, Devices: sleepHaltArray)
                }
                let movingDeviceArray = self.makeMovingDeviceArray(array)
                self.arrForMovingLocations = self.getCoordinates(movingDeviceArray)
                delegate?.updateMovingLocationsOnMap(Locations: self.arrForMovingLocations)
            }
        }
    }
    var arrForMovingLocations:[Latlon] = []
    var arrForHaltAndStopLocations:[Latlon] = []
    weak var delegate : MapVCViewModelDelegate?
}

extension MapVCViewModel {
    func getDeviceData() {
        delegate?.showLoader()
        self.networkServiceCalls.getDeviceData(serialNumber: "IRNS1309", enableSourceDate: "true", startTime: "1593628200000", endTime: "1593714600000") { (state) in
            self.delegate?.hideLoader()
            switch state {
            case .success(let result as [DeviceDataResponse]):
                self.originalDeviceList = self.filterActiveDevicePackets(result)
            case .failure(let error):
                self.delegate?.showError(errorMessage: error)
                printLog(error)
            default:
                self.delegate?.showError(errorMessage: AppSpecificError.unknownError.rawValue)
            }
        }
    }
    
    func makeMovingDeviceArray(_ array: [D]) -> [D] {
        return array.filter({$0.vehicle_mode == "M"})
    }
    
    func filterActiveDevicePackets(_ devices: [DeviceDataResponse]) -> [D] {
        return devices.compactMap({$0.d}).filter({$0.gnss_fix == 1})
    }
    
    func makeSleepAndHaltDeviceArray(_ array: [D]) -> [D]? {
        let filter = array.filter({$0.vehicle_mode != "M"})
        if let firstElement = filter.first {
            var sleepAndHalt = [D]()
            var type = firstElement.vehicle_mode
            sleepAndHalt.append(firstElement)
            for d in filter {
                if d.vehicle_mode != type {
                    sleepAndHalt.append(d)
                    type = d.vehicle_mode
                }
            }
            return sleepAndHalt
        } else {
            printLog("Array empty")
            return nil
        }
    }
    
    func getCoordinates(_ deviceArray: [D])  -> [Latlon] {
        return deviceArray.compactMap({$0.coordinates})
    }
}
