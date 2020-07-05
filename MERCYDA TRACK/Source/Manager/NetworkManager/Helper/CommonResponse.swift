//
//  CommonResponse.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

struct CommonResponse<T : Codable> : Codable {
    
    let status : String?
    var success : Bool?  {
        get {
            return self.status == "success"
        }
    }
    let result  : T?
    let error : ErrorStruct?
    let code : Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "data"
        case error = "error"
        case code = "code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        result = try? values?.decodeIfPresent(T.self, forKey: .result)
        error = try? values?.decodeIfPresent(ErrorStruct.self, forKey: .result)
        code = try? values?.decodeIfPresent(Int.self, forKey: .code)
    }
    
}
