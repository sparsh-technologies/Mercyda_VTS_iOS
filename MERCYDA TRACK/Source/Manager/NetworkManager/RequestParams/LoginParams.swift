//
//  LoginParams.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 30/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire

struct loginParams {
    
    var userName : String?
    var password : String?
    
    
    init(userName :String, password:String) {
        self.userName = userName
        self.password = password
    }
}

extension loginParams: URLBuildable {
    var domainType: BaseAdressType {
        return .MainDomain
    }
    
    var parameters: Parameters? {
        return nil
    }
    var path: String? {
        return WebService.loginPath
    }
    var httpMethod: HTTPMethod {
        return .post
    }
    var acceptType: ContentType {
        return .json
    }
}
