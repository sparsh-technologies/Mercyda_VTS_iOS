//
//  GetLocationAddressParams.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 13/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire


struct getLocationAddressParams {
    
    let locationCoordinates : Latlon
    
    init(locationCoordinates: Latlon) {
        self.locationCoordinates = locationCoordinates
    }
}

extension getLocationAddressParams: URLBuildable {
    var domainType: BaseAdressType {
        return .LocationDomain
    }
    
    var parameters: Parameters? {
        return nil
    }
    var path: String? {
        return queryString()
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var acceptType: ContentType {
        return .json
    }
    
    func queryString() -> String {
        return "&\(PARAMS.LATITUDE)=\(self.locationCoordinates.lat)&\(PARAMS.LONGITUDE)=\(self.locationCoordinates.lon)"
    }
}
