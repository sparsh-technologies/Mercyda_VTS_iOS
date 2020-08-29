//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation
import Alamofire


struct GetAlertParams{
    
    init() {
    }
}

extension GetAlertParams: URLBuildable {
    var domainType: BaseAdressType {
        return .MainDomain
    }
    var parameters: Parameters? {
        return nil
    }
    var path: String? {
       // return WebService.getAlertDataPath
        
        return "mtrack/data?&source_date=true&start_time=\(Utility.getTimeStampForAPI(flag: 1))&end_time=\(Utility.getTimeStampForAPI(flag: 2))&d.mobile_alert=true&meta_d.vehicle_registration=\(vehicleNumber)&username=\(Utility.getUserName())&password=\(Utility.getPassword())"

    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var acceptType: ContentType {
        return .json
    }
}
