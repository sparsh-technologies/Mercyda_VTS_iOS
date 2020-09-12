//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation
import Alamofire

struct FcmRegisterParams {
    let fcm : FcmRegister?
    init(fcm : FcmRegister) {
        self.fcm = fcm
    }
}

extension FcmRegisterParams: URLBuildable {
    var domainType: BaseAdressType {
        return .MainDomain
    }
    
    var parameters: Parameters? {
        return  getParams()
    }
    var path: String? {
        return WebService.fcmRegisterPath
    }
    var httpMethod: HTTPMethod {
        return .post
    }
    var acceptType: ContentType {
        return .json
    }
    
    func getParams() -> [String: Any] {
        do {
        let jsonData = try! JSONEncoder().encode(fcm)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
        return json
        }
        catch let error {
            print("JSON Serialization Error", error)
        }
        return ["":""]
    }
}
