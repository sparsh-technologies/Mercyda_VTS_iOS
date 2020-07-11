/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct D : Codable {
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
		case source_date = "source_date"
		case latitude = "latitude"
		case data = "data"
		case gnss_fix = "gnss_fix"
		case packet_type = "packet_type"
		case valid_status = "valid_status"
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
		source_date = try? values.decodeIfPresent(Int.self, forKey: .source_date)
		latitude = try? values.decodeIfPresent(String.self, forKey: .latitude)
		data = try? values.decodeIfPresent(String.self, forKey: .data)
		gnss_fix = try? values.decodeIfPresent(Int.self, forKey: .gnss_fix)
		packet_type = try? values.decodeIfPresent(String.self, forKey: .packet_type)
		valid_status = try? values.decodeIfPresent(Bool.self, forKey: .valid_status)
	}

}

extension Array where Element == D {
    func filterActivePackets() -> [D] {
        return self.filter({$0.gnss_fix == 1})
    }
    func getMovingPackets() -> [D] {
        return self.filter({$0.vehicle_mode == "M"})
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
}
