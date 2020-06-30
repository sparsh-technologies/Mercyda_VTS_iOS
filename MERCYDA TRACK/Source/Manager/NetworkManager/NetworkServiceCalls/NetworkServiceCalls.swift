//
//  NetworkServiceCalls.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.


import Foundation

class NetworkServiceCalls: NetworkAdapter {
    
    
    // Service call for getting Product for Groceries items
    
    func demoServiceCalls(param1 :String, param2:String, _ completion: @escaping CompletionWithSuccessOrFailure) {
        let params = demoParams(param1 :param1, param2:param2)
        
        fetch(params, CommonParser<demoResponse>.self) { (state) in
            switch state {
            case .success(let response):
                completion(.success(response: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
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
    
}
