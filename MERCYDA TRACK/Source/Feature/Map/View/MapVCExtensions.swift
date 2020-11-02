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
    func updateDistance(distance : String) {
        self.distanceLabel.text = distance
    }
    
    func updateSourceDateOfLastPacket(dateString: String) {
        self.lastUpdatedDateLabel.text = dateString
    }
    
    func updateCarLocationWhenNoMovingLocationFound(Locations locationsArray: [Latlon]) {
        let coordinatesArray = locationsArray.toGoogleCoordinates()
        if coordinatesArray.count > 0 {
            self.focusMapToLocation(loctions: coordinatesArray,duration: 2.0, completionFunction: {
                self.setCarMarkers(carPosition: coordinatesArray.last!, position1: coordinatesArray.last!, position2: coordinatesArray.last!)
            }) {
                // Removed updating markers for now later if needed uncomment the line
                 self.viewModel?.updateParkingMarkers()
            }
        }
    }
    
    func updatePolyLines(Locations locationsArray: [Latlon]) {
        var timer = DispatchTime.now()
        CATransaction.flush()
        let locArray : [CLLocationCoordinate2D] = locationsArray.toGoogleCoordinates().reversed()
        self.polyLineLocations.append(contentsOf: locArray)
        for i in 0..<locArray.count {
            DispatchQueue.main.asyncAfter(deadline: timer, execute: {
                CATransaction.begin()
                self.animationPath.add(locArray[i])
              //  self.path?.add(locArray[i])
                if self.vehicleObject?.route_required ?? false {
                    self.animationPolylineBase.path = self.animationPath
                    self.animationPolylineBase.map = self.mapView
                    self.animationPolyline.path = self.animationPath
                    self.animationPolyline.map = self.mapView
                }
                if locArray.count > 1 {
                self.setCarMarkers(carPosition: locArray[i], position1: locArray[i == locArray.count - 1 ? i-1 : i], position2: locArray[i == locArray.count - 1 ? i : i+1])
                }
                if !self.isPositionWithinScreen(position: locArray[i]) {
                    let camera = GMSCameraPosition.camera(withTarget: locArray[i], zoom: 14)
                    self.mapView?.animate(with: GMSCameraUpdate.setCamera(camera))
                }
                CATransaction.commit()
            })
            timer = timer + 0.015
        }
    }
    
    func isPositionWithinScreen(position: CLLocationCoordinate2D) -> Bool {
        if let region = self.mapView?.projection.visibleRegion() {
            let bounds = GMSCoordinateBounds(region: region)
            return bounds.contains(position)
        }
        return true
    }
    
    func updateParkingLocationsOnMap(Locations locationsArray: [Latlon], Devices deviceArray: [TripDetailsModel]) {
        if vehicleObject?.route_required ?? false {
            self.updateParkingMarkers(Locations: locationsArray.toGoogleCoordinates(), Devices: deviceArray)
        }
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
           // self.getLocationDetails(mapView: mapView, marker: marker, device: device)
            self.showGoogleMapsRedirection(locationCoordinates: device.coordinates)
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let device = marker.userData as? D {
            self.showGoogleMapsRedirection(locationCoordinates: device.coordinates)
        }
        return true
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
    
    func showGoogleMapsRedirection(locationCoordinates: Latlon) {
        let alertController = UIAlertController(title: "Get Directions", message: nil, preferredStyle: .actionSheet)
        let searchAction =  UIAlertAction.init(title: "Google Maps", style: .default) { (action) in
            self.viewModel?.openAppleMapForDirection(location: CLLocation.init(latitude: locationCoordinates.lat, longitude: locationCoordinates.lon))
        }
        alertController.addAction(searchAction)
        alertController.addAction(UIAlertAction.init(title: "Cancel", style:.cancel, handler:nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension Array where Element == Latlon {
    func toGoogleCoordinates() -> [CLLocationCoordinate2D] {
        return self.compactMap({CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon)})
    }
}
