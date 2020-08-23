/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Data : Codable {
	let id : String?
	let d : D?
	let meta_d : Meta_d?
	let serial_no : String?
	let imei_no : String?
	let created_date : Int?
	let created_by : String?
	let source_date : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case d = "d"
		case meta_d = "meta_d"
		case serial_no = "serial_no"
		case imei_no = "imei_no"
		case created_date = "created_date"
		case created_by = "created_by"
		case source_date = "source_date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		d = try values.decodeIfPresent(D.self, forKey: .d)
		meta_d = try values.decodeIfPresent(Meta_d.self, forKey: .meta_d)
		serial_no = try values.decodeIfPresent(String.self, forKey: .serial_no)
		imei_no = try values.decodeIfPresent(String.self, forKey: .imei_no)
		created_date = try values.decodeIfPresent(Int.self, forKey: .created_date)
		created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
		source_date = try values.decodeIfPresent(Int.self, forKey: .source_date)
	}

}