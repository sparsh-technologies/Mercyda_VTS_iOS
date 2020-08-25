//
//  MapVCExtensions.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 08/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import GoogleMaps
import MBProgressHUD

extension MapVC : MapVCViewModelDelegate {
    func updatePolyLines(Locations locationsArray: [Latlon]) {
//        printLog("first")
//        printLog(locationsArray.first)
//        printLog("last")
//        printLog(locationsArray.last)
//
        var timer = DispatchTime.now()
        CATransaction.flush()
        let locArray : [CLLocationCoordinate2D] = locationsArray.toGoogleCoordinates().reversed()
        self.polyLineLocations.append(contentsOf: locArray)
        for i in 0..<locArray.count {
            DispatchQueue.main.asyncAfter(deadline: timer, execute: {
                CATransaction.begin()
                self.animationPath.add(locArray[i])
                self.path?.add(locArray[i])
                self.animationPolylineBase.path = self.animationPath
                self.animationPolylineBase.map = self.mapView
                self.animationPolyline.path = self.animationPath
                self.animationPolyline.map = self.mapView
                self.setCarMarkers(position1: locArray[i], position2: locArray[i == locArray.count - 1 ? i : i+1])
                CATransaction.commit()
            })
            timer = timer + 0.35
        }
    }
    
    
    func updateParkingLocationsOnMap(Locations locationsArray: [Latlon], Devices deviceArray: [TripDetailsModel]) {
        self.updateParkingMarkers(Locations: locationsArray.toGoogleCoordinates(), Devices: deviceArray)
    }
    
    func updateMovingLocationsOnMap(Locations locationsArray: [Latlon]) {
        self.polyLineLocations = locationsArray.toGoogleCoordinates()
        self.updateMap(self.polyLineLocations)
    }
    
    func showLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    func hideLoader() {
        MBProgressHUD.hide(for: view, animated: false)
    }
    func showError(errorMessage: String) {
        statusBarMessage(.CustomError, errorMessage)
    }
}

extension MapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let device = marker.userData as? D {
            self.getLocationDetails(mapView: mapView, marker: marker, device: device)
        }
    }
    
    func getLocationDetails(mapView: GMSMapView, marker: GMSMarker, device: D) {
        self.viewModel?.networkServiceCalls.getLocationDetails(locationCoordinates: device.coordinates) { (result) in
            switch result {
            case .success(response: let response as LocationDetailsResponse):
                printLog("success \(response)")
            case .failure(error: let error):
                statusBarMessage(.CustomError, error)
            default:
                statusBarMessage(.CustomError, AppSpecificError.unknownError.rawValue)
            }
        }
        //  self.delegateForMapPicker?.didSelectMarkerFromMap(selectedD: device)
    }
}

extension Array where Element == Latlon {
    func toGoogleCoordinates() -> [CLLocationCoordinate2D] {
        return self.compactMap({CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon)})
    }
}
