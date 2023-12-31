//
//  GetVehicleDetailParams.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 30/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire

struct getVehicleDetailsParams {
    
    init() {
    }
}

extension getVehicleDetailsParams: URLBuildable {
    var domainType: BaseAdressType {
        return .MainDomain
    }
    
    var parameters: Parameters? {
        return nil
    }
    var path: String? {
        return WebService.getVehiclesDetailsPath
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var acceptType: ContentType {
        return .json
    }
}
