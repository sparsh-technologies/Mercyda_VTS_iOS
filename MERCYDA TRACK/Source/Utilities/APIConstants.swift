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
static let LiveBaseUrl = "http://mobile.mercydatrack.com/"
//URL for Test
static let DevBaseUrl = "http://mobile.mercydatrack.com/"
static let TestBaseUrl = "http://mobile.mercydatrack.com/"
static let GoogleApiBaseUrl = "https://maps.googleapis.com/maps/api/"
    
// API URLS
    
    static let demoDataPath = "api/admin/demo"
    static let loginPath = "mtrack/user/login?username=admin&password=Inf!n!c03312345%23"
    static let getVehiclesCountPath = "mtrack/vehicles/count?username=admin&password=Inf!n!c03312345%23"
    static let getVehiclesListPath = "mtrack/users?role=vehicle&start=0&length=10&username=admin&password=Inf!n!c03312345%23"
    static let getVehiclesDetailsPath = "mtrack/devices/KL01G1234?username=admin&password=Inf!n!c03312345%23"
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
