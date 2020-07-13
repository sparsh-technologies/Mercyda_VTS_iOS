//
//  LocationParser.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 13/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire


class LocationParser <T: Codable> : NSObject {
    var result : T?
    init(_ json: Parameters ) throws {
        if let results = json as Parameters? {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: results, options: [])
                if let resultModel = try? JSONDecoder().decode(T.self, from: jsonData) {
                    self.result = resultModel
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else {
            throw NetworkError.emptyResponse
        }
    }
}

extension LocationParser: NetworkParser {
       
    static func parse(_ json: Parameters) -> CompletionState {
        do {
            if let result = try LocationParser(json).result {
                 return .success(response: result)
            } else {
               return .failure(error: NetworkError.emptyResponse.localizedDescription)
            }
            
        } catch {
            return .failure(error: error.localizedDescription)
        }
    
    }
}
   
    

