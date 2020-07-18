//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation
class Dispatcher {
    let networkServiceCalls = NetworkServiceCalls()
    private var dispatchTask: DispatchWorkItem?
    let queue = DispatchQueue.init(label: "backgroundQueue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
    var time : DispatchTime = DispatchTime.now()
    
    deinit {
        print("Dispatcher object deiniantialized")
    }
    
    
    func getLocationDetails(locationCoordinates: Latlon, block: @escaping (_ cityAddress: String) -> Void) {
        //dispatchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            guard let this = self else {
                return
            }
            this.networkServiceCalls.getLocationDetails(locationCoordinates: locationCoordinates) { (result) in
                switch result {
                case .success(response: let response as LocationDetailsResponse):
                    block("\(response.display_name ?? "")")
                default:
                    printLog("api failure")
                    block("")
                }
            }
        }
        self.dispatchTask = task
        queue.asyncAfter(deadline: time, execute: task)
        time = time + 1
    }
    
}
