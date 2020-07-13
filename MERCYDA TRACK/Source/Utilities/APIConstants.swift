//
//  Constants.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import UIKit


struct WebService {
//URL for live
static let LiveBaseUrl = "http://mobile.mercydatrack.com:8080/"
//URL for Test
static let DevBaseUrl = "http://mobile.mercydatrack.com:8080/"
static let TestBaseUrl = "http://mobile.mercydatrack.com:8080/"
static let GoogleApiBaseUrl = "https://maps.googleapis.com/maps/api/"
static let locationUrl = "https://nominatim.openstreetmap.org/reverse?format=json"
    
// API URLS
    
    static let demoDataPath = "api/admin/demo"
    static let loginPath = "mtrack/user/login?username=\(userName)&password=\(passWord)"
    static let getVehiclesCountPath = "mtrack/vehicles/count?username=\(Utility.getUserName())&password=\(Utility.getPassword())"
    static let getVehiclesListPath = "mtrack/users?role=vehicle&start=0&length=100&username=\(Utility.getUserName())&password=\(Utility.getPassword())"
    static let getVehiclesDetailsPath = "mtrack/devices/KL01G1234?username=\(Utility.getUserName())&password=\(Utility.getPassword())"
    static let getDeviceDataPath = "mtrack/data"

}

struct PARAMS {
    static let SERIAL_NO = "serial_no"
    static let SOURCE_DATE = "source_date"
    static let START_TIME = "start_time"
    static let END_TIME = "end_time"
    static let USERNAME = "username"
    static let PASSWORD = "password"
}

struct APIKeys {
    static let GOOGLE_API_KEY =  "AIzaSyBNY5ak5Fp4BL2ANNlDDssQiVI_q3X1TVk"
}
