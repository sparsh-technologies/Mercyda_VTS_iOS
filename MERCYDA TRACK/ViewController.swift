//
//  ViewController.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit
import FirebaseCrashlytics

class ViewController: UIViewController {
    
    private let networkServiceCalls = NetworkServiceCalls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // self.callLoginservice()
        // self.getVehiclesCount()
        //self.getVehiclesList()
        self.getVehicleDetails()
        //self.getDeviceData()
        
    }
    
    
    func callLoginservice() {
        //Utility.showLoading()
        self.networkServiceCalls.login(userName: "", password: "") { (state) in
            //  Utility.hideLoading()
            switch state {
            case .success(let result as loginResponse):
                printLog("Success \(result)")
            case .failure(let error):
                printLog(error)
                statusBarMessage(.CustomError, error)
            default:
                printLog("")
            }
        }
    }
    
    func getVehiclesCount() {
        self.networkServiceCalls.getVehiclesCount { (state) in
            //  Utility.hideLoading()
            switch state {
            case .success(let result as getVehiclesCountResponse):
                printLog("Success \(result)")
            case .failure(let error):
                printLog(error)
                statusBarMessage(.CustomError, error)
            default:
                printLog("")
            }
        }
    }
    
    func getVehiclesList() {
        self.networkServiceCalls.getVehiclesList { (state) in
            //  Utility.hideLoading()
            switch state {
            case .success(let result as [Vehicle]):
                printLog("Success \(result)")
            case .failure(let error):
                printLog(error)
                statusBarMessage(.CustomError, error)
            default:
                printLog("")
            }
        }
    }
    
    
    func getVehicleDetails() {
        self.networkServiceCalls.getVehicleDetails { (state) in
            //  Utility.hideLoading()
            switch state {
            case .success(let result as getVehicleDetailResponse):
                printLog("Success \(result)")
            case .failure(let error):
                printLog(error)
                statusBarMessage(.CustomError, error)
            default:
                printLog("")
            }
        }
    }
    
    func getDeviceData() {
        self.networkServiceCalls.getDeviceData { (state) in
            //  Utility.hideLoading()
            switch state {
            case .success(let result as getVehicleDetailResponse):
                printLog("Success \(result)")
            case .failure(let error):
                printLog(error)
                statusBarMessage(.CustomError, error)
            default:
                printLog("")
            }
        }
    }

    func crash() {
        fatalError()
    }
}

