/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Last_updated_data : Codable {
	let speed : Int?
    let vehicle_mode : String?
    let ignition : String?
    let gsm_signal_strength : Int?
    let imei_no : String?
    let source_date : Int?
    let longitude : String?
    let latitude : String?
    let overspeed_alert_count : Int?
    let data : String?
    let gnss_fix : Int?
    let serial_no : String?
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
        case speed = "speed"
        case vehicle_mode = "vehicle_mode"
        case ignition = "ignition"
        case gsm_signal_strength = "gsm_signal_strength"
        case imei_no = "imei_no"
        case source_date = "source_date"
        case longitude = "longitude"
        case latitude = "latitude"
        case overspeed_alert_count = "overspeed_alert_count"
        case data = "data"
        case gnss_fix = "gnss_fix"
        case serial_no = "serial_no"
        case packet_type = "packet_type"
        case valid_status = "valid_status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decodeIfPresent(Int.self, forKey: .speed)
        vehicle_mode = try values.decodeIfPresent(String.self, forKey: .vehicle_mode)
        ignition = try values.decodeIfPresent(String.self, forKey: .ignition)
        gsm_signal_strength = try values.decodeIfPresent(Int.self, forKey: .gsm_signal_strength)
        imei_no = try values.decodeIfPresent(String.self, forKey: .imei_no)
        source_date = try values.decodeIfPresent(Int.self, forKey: .source_date)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        overspeed_alert_count = try values.decodeIfPresent(Int.self, forKey: .overspeed_alert_count)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        gnss_fix = try values.decodeIfPresent(Int.self, forKey: .gnss_fix)
        serial_no = try values.decodeIfPresent(String.self, forKey: .serial_no)
        packet_type = try values.decodeIfPresent(String.self, forKey: .packet_type)
        valid_status = try values.decodeIfPresent(Bool.self, forKey: .valid_status)
	}

}
