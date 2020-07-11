/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Vehicle : Codable {
	let modifiedBy : String?
    let modifiedTime : Int?
    let vehicle_type : String?
    let fleet : String?
    let activeInd : String?
    let apply_anomaly_detection_by_statistics : Bool?
    let use_google_api : Bool?
    let vendor : String?
    let role_code : String?
    let dealer : String?
    let last_updated_data : Last_updated_data?
    let alert_count : Int?
    let use_osm_api : Bool?
    let use_mapmyindia_api : Bool?
    let createdTime : Int?
    let id : String?
    let createdBy : String?
    let full_name : String?
    let email : String?
    let mobile : String?
    let overspeed_alert_count : Int?
    let vehicle_registration : String?
    let distributor : String?
    let emergency_alert_count : Int?
    let password : String?
    let address : String?
    let use_infinimap_api : Bool?

	enum CodingKeys: String, CodingKey {
        case modifiedBy = "modifiedBy"
        case modifiedTime = "modifiedTime"
        case vehicle_type = "vehicle_type"
        case fleet = "fleet"
        case activeInd = "activeInd"
        case apply_anomaly_detection_by_statistics = "apply_anomaly_detection_by_statistics"
        case use_google_api = "use_google_api"
        case vendor = "vendor"
        case role_code = "role_code"
        case dealer = "dealer"
        case last_updated_data = "last_updated_data"
        case alert_count = "alert_count"
        case use_osm_api = "use_osm_api"
        case use_mapmyindia_api = "use_mapmyindia_api"
        case createdTime = "createdTime"
        case id = "id"
        case createdBy = "createdBy"
        case full_name = "full_name"
        case email = "email"
        case mobile = "mobile"
        case overspeed_alert_count = "overspeed_alert_count"
        case vehicle_registration = "vehicle_registration"
        case distributor = "distributor"
        case emergency_alert_count = "emergency_alert_count"
        case password = "password"
        case address = "address"
        case use_infinimap_api = "use_infinimap_api"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
        modifiedTime = try values.decodeIfPresent(Int.self, forKey: .modifiedTime)
        vehicle_type = try values.decodeIfPresent(String.self, forKey: .vehicle_type)
        fleet = try values.decodeIfPresent(String.self, forKey: .fleet)
        activeInd = try values.decodeIfPresent(String.self, forKey: .activeInd)
        apply_anomaly_detection_by_statistics = try values.decodeIfPresent(Bool.self, forKey: .apply_anomaly_detection_by_statistics)
        use_google_api = try values.decodeIfPresent(Bool.self, forKey: .use_google_api)
        vendor = try values.decodeIfPresent(String.self, forKey: .vendor)
        role_code = try values.decodeIfPresent(String.self, forKey: .role_code)
        dealer = try values.decodeIfPresent(String.self, forKey: .dealer)
        last_updated_data = try values.decodeIfPresent(Last_updated_data.self, forKey: .last_updated_data)
        alert_count = try values.decodeIfPresent(Int.self, forKey: .alert_count)
        use_osm_api = try values.decodeIfPresent(Bool.self, forKey: .use_osm_api)
        use_mapmyindia_api = try values.decodeIfPresent(Bool.self, forKey: .use_mapmyindia_api)
        createdTime = try values.decodeIfPresent(Int.self, forKey: .createdTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        overspeed_alert_count = try values.decodeIfPresent(Int.self, forKey: .overspeed_alert_count)
        vehicle_registration = try values.decodeIfPresent(String.self, forKey: .vehicle_registration)
        distributor = try values.decodeIfPresent(String.self, forKey: .distributor)
        emergency_alert_count = try values.decodeIfPresent(Int.self, forKey: .emergency_alert_count)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        use_infinimap_api = try values.decodeIfPresent(Bool.self, forKey: .use_infinimap_api)
	}

}
