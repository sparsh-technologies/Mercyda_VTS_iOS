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
        //self.callDemoWebservice()
        //self.crash()
       
    }
    
    
    func callDemoWebservice() {
        //Utility.showLoading()
        self.networkServiceCalls.demoServiceCalls(param1: "", param2: "") { (state) in
            //  Utility.hideLoading()
            switch state {
            case .success(let result as demoResponse):
                printLog("Success \(result)")
            case .failure(let error):
                printLog(error)
            default:
                printLog("")
            }
        }
    }
    
    
    func crash() {
        fatalError()
    }
}

