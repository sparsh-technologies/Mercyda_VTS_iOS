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
static let LiveBaseUrl = "https://mobiles.mercydatrack.com/"
//URL for Test
static let DevBaseUrl = "https://mobiles.mercydatrack.com/"
static let TestBaseUrl = "https://mobiles.mercydatrack.com/"
static let GoogleApiBaseUrl = "https://maps.googleapis.com/maps/api/"
static let locationUrl = "https://nominatim.openstreetmap.org/reverse?format=json"
    
// API URLS
    
    static let demoDataPath = "api/admin/demo"
    static let loginPath = "mtrack/user/login?username=\(uame)&password=\(passWord)&version=v2"
    static let getVehiclesCountPath = "mtrack/vehicles/count?username=\(Utility.getUserName())&password=\(Utility.getPassword())&version=v2"
    static let getVehiclesListPath = "mtrack/users?role=vehicle&start=0&length=100&username=\(Utility.getUserName())&password=\(Utility.getPassword())&version=v2"
    static let getVehiclesDetailsPath = ""
    static let getDeviceDataPath = "mtrack/data"
  //  static let getAlertDataPath = "mtrack/data?start_time=\(Utility.getTimeStampForAPI(flag: 1))&end_time=\(Utility.getTimeStampForAPI(flag: 2))&d.mobile_alert=true&source_date=true&username=\(Utility.getUserName())&password=\(Utility.getPassword())"
  // static let getAlertDataPath = "mtrack/data?start_time=1598034600000&end_time=1598119949140&d.mobile_alert=true&source_date=true&username=fci@gmail.com&password=123456"
    static let getAlertDataPath = "mtrack/data?&source_date=true&start_time=\(Utility.getTimeStampForAPI(flag: 1))&end_time=\(Utility.getTimeStampForAPI(flag: 2))&d.mobile_alert=true&meta_d.vehicle_registration=\(vehicleNumber)&username=\(Utility.getUserName())&password=\(Utility.getPassword())"
    static let fcmRegisterPath = "mtrack/registrationtoken"

}

struct PARAMS {
    static let SERIAL_NO = "serial_no"
    static let SOURCE_DATE = "source_date"
    static let START_TIME = "start_time"
    static let END_TIME = "end_time"
    static let USERNAME = "username"
    static let PASSWORD = "password"
    static let LATITUDE = "lat"
    static let LONGITUDE = "lon"
}

struct APIKeys {
    static let GOOGLE_API_KEY =  "AIzaSyAjcRmEam13vtv1JMjNEUIfBclvRr83XHs"
}
