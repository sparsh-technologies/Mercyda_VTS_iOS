//
//  DashboardViewModel.swift
//  MERCYDA TRACK
//
//  Created by test on 04/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

class DashboardViewModel  {
    // MARK: - Properties
    private let networkServiceCalls = NetworkServiceCalls()
    
    
}
extension DashboardViewModel {
    
    
    func filterVehicleData(type:String, data:[Vehicle],completion:@escaping([Vehicle]) -> Void){
         let resultData = data.filter { $0.last_updated_data?.vehicle_mode == type}
         completion(resultData)
    }
    
    func getVehicleCount(completion: @escaping (WebServiceResult<getVehiclesCountResponse, String>) -> Void) {
        self.networkServiceCalls.getVehiclesCount { (state) in
            switch state {
            case .success(let result as getVehiclesCountResponse):
                completion(.success(result))
                printLog("Vechile details Count \(result)")
            case .failure(let error):
                completion(.failure(error))
                printLog(error)
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
            }
        }
    }
    
    func getVehicleList(completion: @escaping (WebServiceResult<[Vehicle],String>) -> Void){
        self.networkServiceCalls.getVehiclesList { (state) in
            switch state{
            case .success( let result as [Vehicle]):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
                
            }
        }
    }
    
    func getDeviceData(completion: @escaping (WebServiceResult<[DeviceDataResponse], String>) -> Void) {
        self.networkServiceCalls.getDeviceData(serialNumber: "IRNS1309", enableSourceDate: "true", startTime: "1593628200000", endTime: "1593714600000") { (state) in
            switch state {
            case .success(let result as [DeviceDataResponse]):
                completion(.success(result))
                printLog("Vechile details Count \(result)")
            case .failure(let error):
                completion(.failure(error))
                printLog(error)
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
            }
        }
    }
}

   



