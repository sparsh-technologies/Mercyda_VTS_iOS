//
//  NetworkAdapter.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import Alamofire


protocol NetworkParser : class {
    static func parse(_ json: Parameters) -> CompletionState
}
typealias CompletionWithSuccessOrFailure = (_ state: CompletionState) -> Void

class NetworkAdapter {
    let networkEngine = NetworkEngine()
    /*
     
     Parameters
     
     T :- generic type it should confirm to URLBuildable protocol
     U :- generic type it should confirm to Parser protocol
     parser :- It will be Any type confirmed to Parser protocol, used for parsing the response in seperate class
     buildable : - It will be Any type confirmed to URLBuildable protocol. It will provide HTPP request parametes
     completion : - Call back with success or failure cases
     
     */
    final func fetch<T: URLBuildable, U: NetworkParser > (_ buildable: T,
                                                   _ parser: U.Type,
                                                   _ completion: @escaping CompletionWithSuccessOrFailure) {
        
        AF
            .request(buildable)
            .validate()
            .responseJSON { (response) in
                printLog(response.result)

                switch response.result {
                case .success(let value):
                    self.networkEngine.fetch(parser, response: value, completion)
                case .failure(let error):
                    printLog(error)
                    completion(.failure(error: error.localizedDescription))
                }
        }
    }
}

final class NetworkEngine {
    /*
     Parameters
     T :- generic type
     parser : - Parser class
     response : - Response recieved from request
     completion: Call back
     
     */
    func fetch<T: NetworkParser>(_ parser: T.Type, response: Any, _ completion: CompletionWithSuccessOrFailure) {
        if let parameters = response as? Parameters {
//             printLog(Utility.printJsonText(object: parameters))
            self.parse(parser, parametes: parameters, completion)
        } else {
            completion(.failure(error: "Invalid response format"))
        }
    }
    /*
     Parameters
     T :- generic type
     parser : - Parser class
     parametes : - response in [String:Any] format
     */
    fileprivate func parse<T: NetworkParser>(_ parser: T.Type,
                                      parametes: Parameters,
                                      _ completion: CompletionWithSuccessOrFailure) {
        let parsingStauts = T.parse(parametes)
        switch parsingStauts {
        case .success(let value):
            completion(.success(response: value))
        case .failure(let error):
            completion(.failure(error: error))
        }
    }
}
