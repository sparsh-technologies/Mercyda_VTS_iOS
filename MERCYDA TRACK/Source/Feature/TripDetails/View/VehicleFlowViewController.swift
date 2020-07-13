//
//  VehicleFlowViewController.swift
//  MERCYDA TRACK
//
//  Created by test on 09/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit
import MBProgressHUD

/// Protocol
protocol VehicleFlowControllerDelegate: class {
    func loadData(vm: [TripDetailsModel], maxSpd: Double, minSpd: Double, distance: Double)
    
}
class VehicleFlowViewController: BaseViewController {
    @IBOutlet weak var totalDistLbl: UILabel!
    
    @IBOutlet weak var maxSpdLbl: UILabel!
    @IBOutlet weak var minSpdLbl: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    var vehicleFlowViewModel = VehicleFlow()
    var serialNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        vehicleFlowViewModel.delegate = self
        tableViewOutlet.register(UINib(nibName: "VehicleDataFlowTableViewCell", bundle: nil), forCellReuseIdentifier: CellID.VehicleDataFlowCell.rawValue)
        getDeviceDetails()
        
    }
    
    func getDeviceDetails()  {
        MBProgressHUD.showAdded(to: view, animated: true)
        vehicleFlowViewModel.getDeviceData(serialNO: serialNumber) { [weak self] (result) in
            guard let this = self else {
                           return
                       }
                       MBProgressHUD.hide(for: this.view, animated: false)
                       switch result {
                       case .success(_):
                           print("")
                       case .failure(let error):
                           statusBarMessage(.CustomError, error)
                           printLog(error)
                       }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension VehicleFlowViewController: VehicleFlowControllerDelegate {
    func loadData(vm: [TripDetailsModel], maxSpd: Double, minSpd: Double, distance: Double) {
        tableViewOutlet.reloadData()
        minSpdLbl.text = String(minSpd.truncate(places: 2)) + " km/hr"
        maxSpdLbl.text = String(maxSpd.truncate(places: 2)) + " km/hr"
        totalDistLbl.text = String(distance.truncate(places: 2)) + " km"
    }
}