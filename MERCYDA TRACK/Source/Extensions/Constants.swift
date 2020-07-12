//
//  Constants.swift
//  MERCYDA TRACK
//
//  Created by Tony on 01/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation


var userName = ""
var passWord = ""


enum CellID:String {
    
    case LoginCell = "LoginTableviewCell"
}


enum StoryboardName :String {
    case Login = "Login"
    case Dashboard = "Dashboard"
    case ListVehicle = "Vehicle"

}

enum StoryboardID :String {
    case DashboardId = "DasboardController"
    case ListVehicle = "ListVehicleControllerID"
    case LoginStoryBoardId = "LoginStoryBoardId"
    case LOginViewControllerID = "LoginViewControllerId"
    case AboutusViewControllerId = "AboutusViewcontrollerID"
}
