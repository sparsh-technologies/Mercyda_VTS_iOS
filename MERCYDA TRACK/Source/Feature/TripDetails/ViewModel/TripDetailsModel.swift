//
//  TripDetailsModel.swift
//  MERCYDA TRACK
//
//  Created by test on 10/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

struct TripDetailsModel {
    
    var vehicleMode = String()
    var distance = String()
    var startTime = String()
    var averageSpeed = String()
    var duration = DateComponents()
    var latitude = Double()
    var longitude = Double()
    var placeName = String()
    
    var coordinates : Latlon {
           get {
               let lat = self.latitude
               let lon = self.longitude 
               return (lat,lon)
           }
       }
    
    init(mode: String, distance: String, startTime: String, avrgSpeed: String, duration: DateComponents, lat: Double, long: Double, place: String) {
        self.vehicleMode = mode
        self.distance = distance
        self.startTime = startTime
        self.averageSpeed = avrgSpeed
        self.duration = duration
        self.latitude = lat
        self.longitude = long
        self.placeName = place
    }
}

extension Array where Element == TripDetailsModel {
    func getCoordinates()  -> [Latlon] {
        return self.compactMap({$0.coordinates})
    }
}
