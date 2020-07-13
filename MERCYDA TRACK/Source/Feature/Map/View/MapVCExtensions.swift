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
    
    func updateParkingLocationsOnMap(Locations locationsArray: [Latlon], Devices deviceArray: [D]) {
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
        self.viewModel.networkServiceCalls.getLocationDetails(locationCoordinates: device.coordinates) { (result) in
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
