//
//  CommonParser.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire

func printLog(_ printMessage :Any)  {
    #if DEBUG
    print(printMessage)
    #else
    #endif
}

class CommonParser <T: Codable> : NSObject {
    var result : CommonResponse<T>?
    init(_ json: Parameters ) throws {
        if let results = json as Parameters? {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: results, options: [])
                if let resultModel = try? JSONDecoder().decode(CommonResponse<T>.self, from: jsonData) {
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

extension CommonParser: NetworkParser {
    static func parse(_ json: Parameters) -> CompletionState {
        do {
            if let result = try CommonParser(json).result {
                guard let success = result.success else { return .failure(error: "Response Validation not Available") }
                if success {
                    if let result = result.result {
                        return .success(response: result)
                    } else {
                        printLog("Result Field Missing")
                        return .failure(error: "Result Field Missing")
                    }
                } else {
                    if let error = result.error {
                        let errorMessage = "ERROR_CODE_\(error.error_code ?? 0)"
                        return .failure(error: errorMessage)
                    } else {
                        printLog("Error Field Missing")
                        return .failure(error: "Error Field Missing")
                    }
                }
            } else {
                return .failure(error: NetworkError.emptyResponse.localizedDescription)
            }
        } catch {
            return .failure(error: error.localizedDescription)
        }
    }
}
