//
//  NetworkServiceCalls.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.


import Foundation

class NetworkServiceCalls: NetworkAdapter {
    
    // Service call Login
    
    func login(userName :String, password :String, _ completion: @escaping CompletionWithSuccessOrFailure) {
        let params = loginParams(userName :userName, password:password)
        fetch(params, CommonParser<loginResponse>.self) { (state) in
            switch state {
            case .success(let response):
                completion(.success(response: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    // Service call Get Vehicles
    
    func getVehiclesCount( _ completion: @escaping CompletionWithSuccessOrFailure) {
        let params = getVehiclesCountParams()
        fetch(params, CommonParser<getVehiclesCountResponse>.self) { (state) in
            switch state {
            case .success(let response):
                completion(.success(response: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    // Service for get Vehicles list
    
    func getVehiclesList( _ completion: @escaping CompletionWithSuccessOrFailure) {
        let params = getVehicleListParams()
        fetch(params, CommonParser<[Vehicle]>.self) { (state) in
            switch state {
            case .success(let response):
                completion(.success(response: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    // Service for get Vehicles Details
    
    func getVehicleDetails( _ completion: @escaping CompletionWithSuccessOrFailure) {
        let params = getVehicleDetailsParams()
        fetch(params, CommonParser<getVehicleDetailResponse>.self) { (state) in
            switch state {
            case .success(let response):
                completion(.success(response: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    // Service for get Device Data
    
    func getDeviceData( _ completion: @escaping CompletionWithSuccessOrFailure) {
        let params = getDeviceDataParams()
        fetch(params, CommonParser<getVehicleDetailResponse>.self) { (state) in
            switch state {
            case .success(let response):
                completion(.success(response: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    
}