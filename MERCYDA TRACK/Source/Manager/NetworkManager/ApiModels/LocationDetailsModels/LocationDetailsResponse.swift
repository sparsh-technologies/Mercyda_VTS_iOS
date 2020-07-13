/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LocationDetailsResponse : Codable {
	let place_id : Int?
	let licence : String?
	let osm_type : String?
	let osm_id : Int?
	let lat : String?
	let lon : String?
	let display_name : String?
	let address : Address?
	let boundingbox : [String]?

	enum CodingKeys: String, CodingKey {

		case place_id = "place_id"
		case licence = "licence"
		case osm_type = "osm_type"
		case osm_id = "osm_id"
		case lat = "lat"
		case lon = "lon"
		case display_name = "display_name"
		case address = "address"
		case boundingbox = "boundingbox"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		place_id = try? values.decodeIfPresent(Int.self, forKey: .place_id)
		licence = try? values.decodeIfPresent(String.self, forKey: .licence)
		osm_type = try? values.decodeIfPresent(String.self, forKey: .osm_type)
		osm_id = try? values.decodeIfPresent(Int.self, forKey: .osm_id)
		lat = try? values.decodeIfPresent(String.self, forKey: .lat)
		lon = try? values.decodeIfPresent(String.self, forKey: .lon)
		display_name = try? values.decodeIfPresent(String.self, forKey: .display_name)
		address = try? values.decodeIfPresent(Address.self, forKey: .address)
		boundingbox = try? values.decodeIfPresent([String].self, forKey: .boundingbox)
	}

}
