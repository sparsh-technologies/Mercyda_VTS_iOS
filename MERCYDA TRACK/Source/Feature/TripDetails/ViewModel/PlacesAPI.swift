//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation

class PlacesAPI {
    private let networkServiceCalls = NetworkServiceCalls()
}

extension PlacesAPI {
    
    func getPlaceName(coordinates: Latlon, completion: @escaping (WebServiceResult<LocationDetailsResponse, String>) -> Void) {
        networkServiceCalls.getLocationDetails(locationCoordinates: coordinates) { (state) in
            switch state {
            case .success(let result as LocationDetailsResponse):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
                printLog(error)
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
            }
        }
    }
}
