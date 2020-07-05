//
//  GetDeviceDataParams.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 30/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire

struct getDeviceDataParams {
    
    let serialNumber : String
    let enableSourceDate : String
    let startTime : String
    let endTime : String
    
    init(serialNumber: String, enableSourceDate: String, startTime: String, endTime: String) {
        
        self.serialNumber = serialNumber
        self.enableSourceDate = enableSourceDate
        self.startTime = startTime
        self.endTime = endTime
    }
}

extension getDeviceDataParams: URLBuildable {
    
    var parameters: Parameters? {
        return nil
    }
    var path: String? {
        return WebService.getDeviceDataPath + queryString()
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var acceptType: ContentType {
        return .json
    }
    
    func queryString() -> String {
        return "?\(PARAMS.SERIAL_NO)=\(self.serialNumber)&\(PARAMS.SOURCE_DATE)=\(self.enableSourceDate)&\(PARAMS.START_TIME)=\(self.startTime)&\(PARAMS.END_TIME)=\(self.endTime)&\(PARAMS.USERNAME)=\("admin")&\(PARAMS.PASSWORD)=\("Inf!n!c03312345%23")"
    }
}

