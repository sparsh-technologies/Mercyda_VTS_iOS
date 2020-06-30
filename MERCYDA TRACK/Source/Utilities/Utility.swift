//
//  Utility.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit
import SDWebImage
class Utility: NSObject {
  
}

extension Utility {
    class func printJsonText(object: Any) -> String {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: object,
                                                         options: .prettyPrinted),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            return ("JSON string = \n\(theJSONText)")
        }
        return ("JSON string = Error")
    }
}
