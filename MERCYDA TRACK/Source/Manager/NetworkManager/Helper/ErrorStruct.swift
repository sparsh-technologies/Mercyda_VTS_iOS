//
//  ErrorStruct.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

struct ErrorStruct : Codable {
    let error_code : Int?
    let error_message : String?
    
    enum CodingKeys: String, CodingKey {
        case error_code = "error_code"
        case error_message = "message"
    }
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        error_code = try? values?.decodeIfPresent(Int.self, forKey: .error_code)
        error_message = try? values?.decodeIfPresent(String.self, forKey: .error_message)
    }
}
