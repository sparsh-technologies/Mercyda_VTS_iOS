/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct loginResponse : Codable {
	let id : String?
	let createdTime : Int?
	let emergency_alert_count : Int?
	let company_mobile : String?
	let mobile : String?
	let modifiedTime : Int?
	let role_code : String?
	let company_address : String?
	let gst_number : String?
	let modifiedBy : String?
	let alert_count : Int?
	let activeInd : String?
	let password : String?
	let createdBy : String?
	let address : String?
	let vendor : String?
	let company_email : String?
	let organization_name : String?
	let email : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case createdTime = "createdTime"
		case emergency_alert_count = "emergency_alert_count"
		case company_mobile = "company_mobile"
		case mobile = "mobile"
		case modifiedTime = "modifiedTime"
		case role_code = "role_code"
		case company_address = "company_address"
		case gst_number = "gst_number"
		case modifiedBy = "modifiedBy"
		case alert_count = "alert_count"
		case activeInd = "activeInd"
		case password = "password"
		case createdBy = "createdBy"
		case address = "address"
		case vendor = "vendor"
		case company_email = "company_email"
		case organization_name = "organization_name"
		case email = "email"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try? values.decodeIfPresent(String.self, forKey: .id)
		createdTime = try? values.decodeIfPresent(Int.self, forKey: .createdTime)
		emergency_alert_count = try? values.decodeIfPresent(Int.self, forKey: .emergency_alert_count)
		company_mobile = try? values.decodeIfPresent(String.self, forKey: .company_mobile)
		mobile = try? values.decodeIfPresent(String.self, forKey: .mobile)
		modifiedTime = try? values.decodeIfPresent(Int.self, forKey: .modifiedTime)
		role_code = try? values.decodeIfPresent(String.self, forKey: .role_code)
		company_address = try? values.decodeIfPresent(String.self, forKey: .company_address)
		gst_number = try? values.decodeIfPresent(String.self, forKey: .gst_number)
		modifiedBy = try? values.decodeIfPresent(String.self, forKey: .modifiedBy)
		alert_count = try? values.decodeIfPresent(Int.self, forKey: .alert_count)
		activeInd = try? values.decodeIfPresent(String.self, forKey: .activeInd)
		password = try? values.decodeIfPresent(String.self, forKey: .password)
		createdBy = try? values.decodeIfPresent(String.self, forKey: .createdBy)
		address = try? values.decodeIfPresent(String.self, forKey: .address)
		vendor = try? values.decodeIfPresent(String.self, forKey: .vendor)
		company_email = try? values.decodeIfPresent(String.self, forKey: .company_email)
		organization_name = try? values.decodeIfPresent(String.self, forKey: .organization_name)
		email = try? values.decodeIfPresent(String.self, forKey: .email)
	}

}
