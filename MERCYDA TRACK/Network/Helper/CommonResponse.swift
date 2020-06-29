//
//  CommonResponse.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

struct CommonResponse<T : Codable> : Codable {

    let success : Bool?
    let result  : T?
    let error : ErrorStruct?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case result = "result"
        case error = "error"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        success = try? values?.decodeIfPresent(Bool.self, forKey: .success)
        result = try? values?.decodeIfPresent(T.self, forKey: .result)
        error = try? values?.decodeIfPresent(ErrorStruct.self, forKey: .error)
    }
    
}
