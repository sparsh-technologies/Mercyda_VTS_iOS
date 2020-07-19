//
//  ListVehicleViewModel.swift
//  MERCYDA TRACK
//
//  Created by Tony on 14/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation



class ListVehicleViewModel{
    
    let networkServiceCalls = NetworkServiceCalls()
    
    
    func searchData(key:String,data:[Vehicle],completion:@escaping([Vehicle]) -> Void){
        printLog("Count:\(data.count)")
        let filtered = data.filter {
            return $0.vehicle_registration?.range(of: key, options: .caseInsensitive) != nil
        }
        completion(filtered)
    }
    
}

