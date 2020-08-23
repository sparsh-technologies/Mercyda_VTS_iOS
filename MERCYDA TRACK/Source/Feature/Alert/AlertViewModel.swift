//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation

class AlertViewModel {
    private let networkServiceCalls = NetworkServiceCalls()
func getAlertData(completion: @escaping (WebServiceResult<AlertResponse,String>) -> Void){
           self.networkServiceCalls.getAlertDetails { (state) in
               switch state{
               case .success( let result as AlertResponse):
                   completion(.success(result))
               case .failure(let error):
                   completion(.failure(error))
               default:
                   completion(.failure(AppSpecificError.unknownError.rawValue))
                   
               }
           }
       }
}
