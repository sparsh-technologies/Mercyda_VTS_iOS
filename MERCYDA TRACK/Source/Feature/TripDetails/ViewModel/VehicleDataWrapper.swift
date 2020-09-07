//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation

class vehicleDataWrapper: NSObject, NSCoding {
    
    
    let emergency_alert_count : Int?
    let speed : Int?
    let vehicle_mode : String?
    let ignition : String?
    let gsm_signal_strength : Int?
    let alert_count : Int?
    let imei_no : String?
    let longitude : String?
    let source_date : Int?
    let latitude : String?
    let data : String?
    let gnss_fix : Int?
    let packet_type : String?
    let valid_status : Bool?
    let overspeed_alert_count : Int?
    let wire_cut_alert_count : Int?
    let main_power_removal_alert_count : Int?
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let vehicle_mode = aDecoder.decodeObject(forKey: "vehicle_mode") as? String,
            let ignition = aDecoder.decodeObject(forKey: "ignition") as? String,
            let imei_no = aDecoder.decodeObject(forKey: "imei_no") as? String,
            let longitude = aDecoder.decodeObject(forKey: "longitude") as? String,
            let latitude = aDecoder.decodeObject(forKey: "latitude") as? String,
            let data = aDecoder.decodeObject(forKey: "data") as? String,
            let packet_type = aDecoder.decodeObject(forKey: "packet_type") as? String,
            let emergency_alert_count = aDecoder.decodeObject(forKey: "emergency_alert_count") as? Int,
            let speed = aDecoder.decodeObject(forKey: "speed") as? Int,
            let gsm_signal_strength = aDecoder.decodeObject(forKey: "gsm_signal_strength") as? Int,
            let alert_count = aDecoder.decodeObject(forKey: "alert_count") as? Int,
            let source_date = aDecoder.decodeObject(forKey: "source_date") as? Int,
            let gnss_fix = aDecoder.decodeObject(forKey: "gnss_fix") as? Int,
            let overspeed_alert_count = aDecoder.decodeObject(forKey: "overspeed_alert_count") as? Int,
            let wire_cut_alert_count = aDecoder.decodeObject(forKey: "wire_cut_alert_count") as? Int,
            let main_power_removal_alert_count = aDecoder.decodeObject(forKey: "main_power_removal_alert_count") as? Int,
            let valid_status = aDecoder.decodeObject(forKey: "valid_status") as? Bool
            
            else {
                return nil
        }
        self.vehicle_mode = vehicle_mode
        self.ignition = ignition
        self.imei_no = imei_no
        self.longitude = longitude
        self.latitude = latitude
        self.data = data
        self.packet_type = packet_type
        self.emergency_alert_count = emergency_alert_count
        self.speed = speed
        self.gsm_signal_strength = gsm_signal_strength
        self.alert_count = alert_count
        self.source_date = source_date
        self.gnss_fix = gnss_fix
        self.overspeed_alert_count = overspeed_alert_count
        self.wire_cut_alert_count = wire_cut_alert_count
        self.main_power_removal_alert_count = main_power_removal_alert_count
        self.valid_status = valid_status
        
    }
    
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.vehicle_mode, forKey: "vehicle_mode")
        coder.encode(self.ignition, forKey: "ignition")
        coder.encode(self.imei_no, forKey: "imei_no")
        coder.encode(self.longitude, forKey: "longitude")
        coder.encode(self.latitude, forKey: "latitude")
        coder.encode(self.data, forKey: "data")
        coder.encode(self.packet_type, forKey: "packet_type")
        coder.encode(self.emergency_alert_count, forKey: "emergency_alert_count")
        coder.encode(self.speed, forKey: "speed")
        coder.encode(self.gsm_signal_strength, forKey: "gsm_signal_strength")
        coder.encode(self.alert_count, forKey: "alert_count")
        coder.encode(self.source_date, forKey: "source_date")
        coder.encode(self.gnss_fix, forKey: "gnss_fix")
        coder.encode(self.overspeed_alert_count, forKey: "overspeed_alert_count")
        coder.encode(self.wire_cut_alert_count, forKey: "wire_cut_alert_count")
        coder.encode(self.main_power_removal_alert_count, forKey: "main_power_removal_alert_count")
        coder.encode(self.valid_status, forKey: "valid_status")
        
    }
    
}
