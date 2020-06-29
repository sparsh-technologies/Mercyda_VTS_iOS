//
//  DemoParams.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.


import Foundation
import Alamofire

struct demoParams {
    
    var param1 : String?
    var param2 : String?
    
    
    init(param1 :String, param2:String) {
        self.param1 = param1
        self.param2 = param2
    }
}

extension demoParams: URLBuildable {
    
    var parameters: Parameters? {
        return prepareParameters()
    }
    var path: String? {
        return WebService.demoDataPath
    }
    var httpMethod: HTTPMethod {
        return .post
    }
    var acceptType: ContentType {
        return .json
    }
    func prepareParameters() -> Parameters {
        
        var paramDict =  [String: Any]()
        // itemid
        if let param1 = self.param1 {
            paramDict[PARAMS.PARAM1] = param1
        }
        // userid
        if let param2 = self.param2 {
            paramDict[PARAMS.PARAM2] = param2
        }
        
        return paramDict
    }
}

