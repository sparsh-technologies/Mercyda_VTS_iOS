/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct getVehicleDetailResponse : Codable {
	let id : String?
	let distributor : String?
	let active_ind : String?
	let version : String?
	let created_time : Int?
	let imei_no : String?
	let created_by : String?
	let vehicle_registration : String?
	let modified_time : String?
	let sub_dealer : String?
	let dealer : String?
	let vendor : String?
	let serial_no : String?
	let fleet : String?
	let meta_d : Meta_d?
	let modified_by : String?
	let last_updated_time : String?
	let device_type_id : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case distributor = "distributor"
		case active_ind = "active_ind"
		case version = "version"
		case created_time = "created_time"
		case imei_no = "imei_no"
		case created_by = "created_by"
		case vehicle_registration = "vehicle_registration"
		case modified_time = "modified_time"
		case sub_dealer = "sub_dealer"
		case dealer = "dealer"
		case vendor = "vendor"
		case serial_no = "serial_no"
		case fleet = "fleet"
		case meta_d = "meta_d"
		case modified_by = "modified_by"
		case last_updated_time = "last_updated_time"
		case device_type_id = "device_type_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try? values.decodeIfPresent(String.self, forKey: .id)
		distributor = try? values.decodeIfPresent(String.self, forKey: .distributor)
		active_ind = try? values.decodeIfPresent(String.self, forKey: .active_ind)
		version = try? values.decodeIfPresent(String.self, forKey: .version)
		created_time = try? values.decodeIfPresent(Int.self, forKey: .created_time)
		imei_no = try? values.decodeIfPresent(String.self, forKey: .imei_no)
		created_by = try? values.decodeIfPresent(String.self, forKey: .created_by)
		vehicle_registration = try? values.decodeIfPresent(String.self, forKey: .vehicle_registration)
		modified_time = try? values.decodeIfPresent(String.self, forKey: .modified_time)
		sub_dealer = try? values.decodeIfPresent(String.self, forKey: .sub_dealer)
		dealer = try? values.decodeIfPresent(String.self, forKey: .dealer)
		vendor = try? values.decodeIfPresent(String.self, forKey: .vendor)
		serial_no = try? values.decodeIfPresent(String.self, forKey: .serial_no)
		fleet = try? values.decodeIfPresent(String.self, forKey: .fleet)
		meta_d = try? values.decodeIfPresent(Meta_d.self, forKey: .meta_d)
		modified_by = try? values.decodeIfPresent(String.self, forKey: .modified_by)
		last_updated_time = try? values.decodeIfPresent(String.self, forKey: .last_updated_time)
		device_type_id = try? values.decodeIfPresent(String.self, forKey: .device_type_id)
	}

}
