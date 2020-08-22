//
//  Constants.swift
//  MERCYDA TRACK
//
//  Created by Tony on 01/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation


var uame = ""
var passWord = ""


enum CellID:String {
    
    case LoginCell = "LoginTableviewCell"
    case VehicleDataFlowCell = "VehicleDataFlowCellID"
    
}


enum StoryboardName :String {
    case Login = "Login"
    case Dashboard = "Dashboard"
    case ListVehicle = "Vehicle"
    case VehicleFlow = "VehicleFlow"
    case AboutUs = "AbouUs"

}

enum StoryboardID :String {
    case DashboardId = "DasboardController"
    case ListVehicle = "ListVehicleControllerID"
    case VehicleFlow = "VehicleFlowID"
    case LoginStoryBoardId = "LoginStoryBoardId"
    case LOginViewControllerID = "LoginViewControllerId"
    case AboutusViewControllerId = "AboutusViewcontrollerID"
    case AboutusWebviewDetailpage = "AboutusWebviewDetailpage"
    case AlertVCId = "AlertVC"
}


enum AboutusPageUrls:String{
    case MainUrl = "http://mercyda.co.in/index.html"
    case ContactUS = "http://mercyda.co.in/contact.html"
   // case PrivacyPolicy = "http://mercyda.co.in/index.html"
  // case TermsAndConditions = "http://mercyda.co.in/index.html"
}
