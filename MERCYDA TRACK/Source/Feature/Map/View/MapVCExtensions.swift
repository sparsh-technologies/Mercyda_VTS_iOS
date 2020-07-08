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
    
    func updateParkingLocationsOnMap(Locations locationsArray: [CLLocationCoordinate2D], Devices deviceArray: [D]) {
        self.updateParkingMarkers(Locations: locationsArray, Devices: deviceArray)
    }
    
    func updateMovingLocationsOnMap(Locations locationsArray: [CLLocationCoordinate2D]) {
        self.polyLineLocations = locationsArray
        self.updateMap(locationsArray)
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
            
            self.dismiss(animated: false) {
                self.delegateForMapPicker?.didSelectMarkerFromMap(selectedD: device)
            }
        }
    }
}
