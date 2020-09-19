//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation

class vehicleDataWrapper: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true    
    var innerD : D?
    
    init(d: D) {
        self.innerD = d
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.innerD = D(coder: aDecoder)
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(self.innerD?.longitude, forKey: "longitude")
        coder.encode(self.innerD?.latitude, forKey: "latitude")
        coder.encode(self.innerD?.emergency_alert_count, forKey: "emergency_alert_count")
        coder.encode(self.innerD?.speed, forKey: "speed")
        coder.encode(self.innerD?.vehicle_mode, forKey: "vehicle_mode")
        coder.encode(self.innerD?.ignition, forKey: "ignition")
        coder.encode(self.innerD?.gsm_signal_strength, forKey: "gsm_signal_strength")
        coder.encode(self.innerD?.alert_count, forKey: "alert_count")
        coder.encode(self.innerD?.imei_no, forKey: "imei_no")
        coder.encode(self.innerD?.source_date, forKey: "source_date")
        coder.encode(self.innerD?.data, forKey: "data")
        coder.encode(self.innerD?.gnss_fix, forKey: "gnss_fix")
        coder.encode(self.innerD?.packet_type, forKey: "packet_type")
        coder.encode(self.innerD?.valid_status, forKey: "valid_status")
        coder.encode(self.innerD?.overspeed_alert_count, forKey: "overspeed_alert_count")
        coder.encode(self.innerD?.wire_cut_alert_count, forKey: "wire_cut_alert_count")
        coder.encode(self.innerD?.main_power_removal_alert_count, forKey: "main_power_removal_alert_count")
        coder.encode(self.innerD?.id, forKey: "id")
    }
    
}

extension Array where Element == vehicleDataWrapper {
func convertToDArray() -> [D] {
    return self.compactMap({$0.innerD})
}
}
