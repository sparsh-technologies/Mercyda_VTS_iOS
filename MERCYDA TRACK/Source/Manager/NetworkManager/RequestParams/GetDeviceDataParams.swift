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
    var domainType: BaseAdressType {
        return .MainDomain
    }
    
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
        return "?\(PARAMS.SERIAL_NO)=\(self.serialNumber)&\(PARAMS.SOURCE_DATE)=\(self.enableSourceDate)&\(PARAMS.START_TIME)=\(self.startTime)&\(PARAMS.END_TIME)=\(self.endTime)&\(PARAMS.USERNAME)=\(Utility.getUserName())&\(PARAMS.PASSWORD)=\(Utility.getPassword())"
        
        // For Testing Mockdata
        // Total Distance is: 2.76km
//        "?serial_no=BIJUSDEVICE1&start_time=1596479400000&source_date=true&username=admin&password=Inf!n!c03312345%23"
    }
}

