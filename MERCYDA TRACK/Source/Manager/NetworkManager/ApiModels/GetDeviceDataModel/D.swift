/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct D : Codable, Hashable, Equatable {
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
    
    var coordinates : Latlon {
        get {
            let lat = Double(self.latitude ?? "0000.00000")!
            let lon = Double(self.longitude ?? "0000.00000")!
            return (lat,lon)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case emergency_alert_count = "emergency_alert_count"
        case speed = "speed"
        case vehicle_mode = "vehicle_mode"
        case ignition = "ignition"
        case gsm_signal_strength = "gsm_signal_strength"
        case alert_count = "alert_count"
        case imei_no = "imei_no"
        case longitude = "longitude"
        case latitude = "latitude"
        case data = "data"
        case gnss_fix = "gnss_fix"
        case packet_type = "packet_type"
        case valid_status = "valid_status"
        case source_date = "source_date"
        case overspeed_alert_count = "overspeed_alert_count"
        case wire_cut_alert_count = "wire_cut_alert_count"
        case main_power_removal_alert_count = "main_power_removal_alert_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        emergency_alert_count = try? values.decodeIfPresent(Int.self, forKey: .emergency_alert_count)
        speed = try? values.decodeIfPresent(Int.self, forKey: .speed)
        vehicle_mode = try? values.decodeIfPresent(String.self, forKey: .vehicle_mode)
        ignition = try? values.decodeIfPresent(String.self, forKey: .ignition)
        gsm_signal_strength = try? values.decodeIfPresent(Int.self, forKey: .gsm_signal_strength)
        alert_count = try? values.decodeIfPresent(Int.self, forKey: .alert_count)
        imei_no = try? values.decodeIfPresent(String.self, forKey: .imei_no)
        longitude = try? values.decodeIfPresent(String.self, forKey: .longitude)
        latitude = try? values.decodeIfPresent(String.self, forKey: .latitude)
        data = try? values.decodeIfPresent(String.self, forKey: .data)
        gnss_fix = try? values.decodeIfPresent(Int.self, forKey: .gnss_fix)
        packet_type = try? values.decodeIfPresent(String.self, forKey: .packet_type)
        valid_status = try? values.decodeIfPresent(Bool.self, forKey: .valid_status)
        source_date = try? values.decodeIfPresent(Int.self, forKey: .source_date)
        overspeed_alert_count = try? values.decodeIfPresent(Int.self, forKey: .overspeed_alert_count)
        wire_cut_alert_count = try? values.decodeIfPresent(Int.self, forKey: .overspeed_alert_count)
        main_power_removal_alert_count = try? values.decodeIfPresent(Int.self, forKey: .overspeed_alert_count)
    }
    
    init(coder aDecoder: NSCoder) {
        
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String
        emergency_alert_count = aDecoder.decodeObject(forKey: "emergency_alert_count") as? Int
        speed = aDecoder.decodeObject(forKey: "speed") as? Int
        vehicle_mode = aDecoder.decodeObject(forKey: "vehicle_mode") as? String
        ignition = aDecoder.decodeObject(forKey: "ignition") as? String
        gsm_signal_strength = aDecoder.decodeObject(forKey: "gsm_signal_strength") as? Int
        alert_count = aDecoder.decodeObject(forKey: "alert_count") as? Int
        imei_no = aDecoder.decodeObject(forKey: "imei_no") as? String
        data = aDecoder.decodeObject(forKey: "data") as? String
        gnss_fix = aDecoder.decodeObject(forKey: "gnss_fix") as? Int
        packet_type = aDecoder.decodeObject(forKey: "packet_type") as? String
        valid_status = aDecoder.decodeObject(forKey: "valid_status") as? Bool
        source_date = aDecoder.decodeObject(forKey: "source_date") as? Int
        overspeed_alert_count = aDecoder.decodeObject(forKey: "overspeed_alert_count") as? Int
        wire_cut_alert_count = aDecoder.decodeObject(forKey: "wire_cut_alert_count") as? Int
        main_power_removal_alert_count = aDecoder.decodeObject(forKey: "main_power_removal_alert_count") as? Int
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(source_date)
    }
    
    static func == (lhs: D, rhs: D) -> Bool {
        return lhs.source_date == rhs.source_date
    }
    
}

extension Array where Element == D {
    func filterActivePackets() -> [D] {
        return self.filter({$0.gnss_fix == 1})
    }
    func getMovingPackets() -> [D] {
        return self.filter({($0.vehicle_mode == "M" || $0.vehicle_mode == "H") && $0.speed ?? 0 > 0})
    }
    func getNonMovingPackets() -> [D] {
        return self.filter({$0.vehicle_mode != "M"})
    }
    func getCoordinates()  -> [Latlon] {
        return self.compactMap({$0.coordinates})
    }
    func getSleepAndHaltDeviceArray() -> [D]? {
        let filter = self.getNonMovingPackets()
        if let firstElement = filter.first {
            var sleepAndHalt = [D]()
            var type = firstElement.vehicle_mode
            sleepAndHalt.append(firstElement)
            for d in filter {
                if d.vehicle_mode != type {
                    sleepAndHalt.append(d)
                    type = d.vehicle_mode
                }
            }
            return sleepAndHalt
        } else {
            printLog("Array empty")
            return nil
        }
    }
    
    func get2DimensionalFilterArray() -> [[D]] {
        var base = [[D]]()
        var tempArray = [D]()
        var type = self.first
        let constant = "S"
        var clear = true
        
        func appendArray() {
            if tempArray.count > 0 {
                base.append(tempArray)
            }
            tempArray.removeAll()
        }
        
        for (index, element) in self.enumerated() {
            type = element
            if type?.vehicle_mode == constant {
                if !clear {
                    appendArray()
                    clear = !clear
                }
            } else {
                if clear {
                    appendArray()
                    clear = !clear
                }
            }
            tempArray.append(element)
            if index == self.count - 1 {
                appendArray()
            }
        }
        var filterWithoutH = base.filter({!($0.count == 1 && $0.contains(where: ({$0.vehicle_mode == "H"})))})
        filterWithoutH.combineNearestS()
        filterWithoutH.combineNearestS()
        filterWithoutH.swapFirstAndLastSleepIntoMoving(constant: constant)
        filterWithoutH.combineNearestMoving()
        filterWithoutH.combineNearestMoving()
        return base
    }
    
}

extension Array where Element == [D] {
    mutating func swapFirstAndLastSleepIntoMoving(constant: String) {
        if self.count > 1 {
            for index in 0..<self.count - 1 {
                if let lastElement = self[index].last, lastElement.vehicle_mode ?? "" == constant && self[index + 1].contains(where: {$0.vehicle_mode ?? "" == "M"}) {
                    self[index + 1].insert(lastElement, at: 0)
                   // self[index].removeLast()
                } else if let firstElement = self[index + 1].first, firstElement.vehicle_mode ?? "" == constant && self[index].contains(where: {$0.vehicle_mode ?? "" == "M"}) {
                   // self[index + 1].removeFirst()
                    self[index].append(firstElement)
                }
            }
        }
        self = self.filter({ $0.count > 1 })
    }
    
    mutating func combineNearestMoving() {
        if self.count > 1 {
            for index in 0..<self.count - 1 {
                if self[index + 1].contains(where: {$0.vehicle_mode ?? "" == "M"}) && self[index].contains(where: {$0.vehicle_mode ?? "" == "M"}) {
                    self[index].append(contentsOf: self[index + 1])
                    self[index + 1].removeAll()
                }
            }
        }
        self = self.filter({ $0.count > 0 })
    }
    mutating func combineNearestS() {
        if self.count > 1 {
            for index in 0..<self.count - 1 {
                if self[index + 1].contains(where: {$0.vehicle_mode ?? "" == "S"}) && self[index].contains(where: {$0.vehicle_mode ?? "" == "S"}) {
                    self[index].append(contentsOf: self[index + 1])
                    self[index + 1].removeAll()
                }
            }
        }
        self = self.filter({ $0.count > 0 })
    }
    
}
