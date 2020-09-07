//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation

class vehicleDataWrapper: NSObject, NSCoding {
    
    
    var innerD : D?
    
    init(d: D) {
        self.innerD = d
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        guard let innerD = aDecoder.decodeObject(forKey: "d") as? D
            
            else {
                return nil
        }
        self.innerD = innerD
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(self.innerD, forKey: "d")
    }
    
}
