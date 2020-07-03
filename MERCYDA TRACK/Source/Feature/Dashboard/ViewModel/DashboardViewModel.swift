//
//  DashboardViewModel.swift
//  MERCYDA TRACK
//
//  Created by test on 04/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

struct CustomError: Error {
    let somethingBadHappened: String
}

class DashboardViewModel  {
    // MARK: - Properties
    private let networkServiceCalls = NetworkServiceCalls()
    
    
}
extension DashboardViewModel {
    
    func getVehicleCount(completion: @escaping (Result<getVehiclesCountResponse, Error>) -> Void) {
        self.networkServiceCalls.getVehiclesCount { (state) in
            switch state {
            case .success(let result as getVehiclesCountResponse):
                completion(.success(result))
                printLog("Vechile details Count \(result)")
            case .failure(let error):
                let abc = CustomError(somethingBadHappened: error)
                completion(.failure(abc))
                printLog(error)
            default:
                printLog("")
            }
        }
    }
}

