//
//  DashboardLocalization.swift
//  MERCYDA TRACK
//
//  Created by Team Kochi on 03/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

/// Login Localization
enum DashboardLocalization: String, Localizable {
    case bottomBanner = "www.mercydaz.com"
    case movingLbl = "MOVING"
    case idleLbl = "IDLE"
    case sleepLbl = "SLEEP"
    case onlineLbl = "ONLINE"
    case offlineLbl = "OFFLINE"
    case alertsLbl = "ALERTS"
    case dashboardLbl = "DASHBOARD"
    case reportsLbl = "REPORTS"
    case totalVechiles = "Total Vechicles"
    case sleepVehicleKey = "S"
    case movingVehicleKey = "M"
    case idleVehicleKey = "H"
}


enum Vehicletype:String{
    case Moving = "moving"
    case Sleep = "sleep"
    case Idle = "idle"
    case Online = "online"
    case Offline = "offline"
}
