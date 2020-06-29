//
//  DemoResponse.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class demoResponse : Codable {
    
    let order_id : String?

    enum CodingKeys: String, CodingKey {
        case order_id = "order_id"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try? values.decodeIfPresent(String.self, forKey: .order_id)
    }
}
