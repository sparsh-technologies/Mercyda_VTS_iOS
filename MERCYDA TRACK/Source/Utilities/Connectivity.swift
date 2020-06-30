//
//  Connectivity.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Alamofire

/// Class for check Connectivity
final class Connectivity {
    
    /// Check network reachable
    static var isReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
