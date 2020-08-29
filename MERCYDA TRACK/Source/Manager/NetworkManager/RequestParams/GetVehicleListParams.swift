//
//  GetVehicleListParams.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 30/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire

struct getVehicleListParams {
    
    init() {
    }
}

extension getVehicleListParams: URLBuildable {
    var domainType: BaseAdressType {
        return .MainDomain
    }
    var parameters: Parameters? {
        return nil
    }
    var path: String? {
      //  return WebService.getVehiclesListPath
        return "mtrack/users?role=vehicle&start=0&length=100&username=\(Utility.getUserName())&password=\(Utility.getPassword())&version=v2"
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var acceptType: ContentType {
        return .json
    }
}

