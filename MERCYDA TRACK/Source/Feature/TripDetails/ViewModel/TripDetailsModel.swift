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
    var duration = String()
    
    init(mode: String, distance: String, startTime: String, avrgSpeed: String, duration: String) {
        self.vehicleMode = mode
        self.distance = distance
        self.startTime = startTime
        self.averageSpeed = avrgSpeed
        self.duration = duration
    }
}
