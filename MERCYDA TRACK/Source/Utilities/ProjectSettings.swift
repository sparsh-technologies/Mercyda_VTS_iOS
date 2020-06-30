//
//  ProjectSettings.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

let buildEnvironment: BuildEnvironment = .prod
enum BuildEnvironment {

    case  prod
    case  staging
    case  google
    var baseUrl: String {
        switch self {
        case .prod:     return WebService.LiveBaseUrl
        case .staging:  return WebService.TestBaseUrl
        case .google:   return WebService.GoogleApiBaseUrl
        }
    }
}

var isLogEnabled: Bool {
    if buildEnvironment != .prod {
        return true
    }
//    if SwifterSwift.isRunningOnSimulator{
//        return true
//    }
    else {
        //For PROD build debugger log should be disabled
        return false
    }
}

//enum userDefaults: String {
//    case userDeviceId = "user_device_Id"    //  device id provided from server after deviceregistration service call
//    case currentUser = "current_user"       //  userId provided from server
//    case vendorId = "device_ud_id"          //  vendor Id , phone physical address
//    case phpPath = "phpPath"
//    case phpBaseURL = "phpBaseURL"
//
//    var value: String {
//        switch self {
//        case .userDeviceId: return UserDefaults.standard.value(forKey: "deviceId") as? String ?? "0"
//        case .currentUser:  return UserDefaults.standard.value(forKey: "currentUser") as? String ?? "0"
//        case .vendorId:   return UserDefaults.standard.value(forKey: "vendorID") as? String ?? "0"
//        case .phpPath : return UserDefaults.standard.value(forKey: "phpPath") as? String ?? ""
//        case .phpBaseURL: return UserDefaults.standard.value(forKey: "phpBaseURL") as? String ?? ""
//        }
//    }
//}

