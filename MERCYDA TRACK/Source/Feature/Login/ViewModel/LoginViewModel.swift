//
//  LoginViewModel.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

/// Login ViewModel
final class LoginViewModel {
    
    // MARK: - Properties
    private let networkServiceCalls = NetworkServiceCalls()
    
}

// MARK: - Internal Methds

extension LoginViewModel {
    
    /// Login User
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    ///   - completion: return type failure/success
    func loginUser(withEmail email: String,
                   password: String,
                   completion: @escaping (Result<loginResponse, Error>) -> Void) {
        self.networkServiceCalls.login(userName: "", password: "") { (state) in
            //  Utility.hideLoading()
            switch state {
            case .success(let result as loginResponse):
                completion(.success(result))
                printLog("Success \(result)")
            case .failure(let error):
                printLog(error)
            default:
                printLog("")
            }
        }
        
    }
}

// MARK: - Static Methds

extension LoginViewModel {
    
    /// Return isUser Loggedin as Bool
    //    static func isUserLoggedIn() -> Bool {
    //
    //    }
}