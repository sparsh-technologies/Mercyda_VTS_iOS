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
        return WebService.getAlertDataPath
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var acceptType: ContentType {
        return .json
    }
}
