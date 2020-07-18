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
    func reloadData()
}

final class VehicleFlowViewController: BaseViewController {
    
    @IBOutlet weak var pickerContainView: UIView!
    @IBOutlet  weak var pickerView: UIView!
    @IBOutlet  weak var datePicker: UIDatePicker!
    @IBOutlet private weak var totalDistLbl: UILabel!
    @IBOutlet  weak var PickerCancelBtn: UIButton!
    @IBOutlet  weak var pickerDoneBtn: UIButton!
    @IBOutlet  weak var pickerBtn: UIButton!
    @IBOutlet private weak var maxSpdLbl: UILabel!
    @IBOutlet private weak var minSpdLbl: UILabel!
    @IBOutlet  private weak var tableViewOutlet: UITableView!
    @IBOutlet private weak var vehicleContainerView: UIView!
    var vehicleFlowViewModel = VehicleFlow()
    var serialNumber = String()
    var APItimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        vehicleFlowViewModel.delegate = self
        tableViewOutlet.register(UINib(nibName: "VehicleDataFlowTableViewCell", bundle: nil), forCellReuseIdentifier: CellID.VehicleDataFlowCell.rawValue)
        getDeviceDetails()
        vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        showDatePicker()
    }
    
    override func viewWillLayoutSubviews() {
        vehicleContainerView.roundCorners(.allCorners, radius: 15)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        APItimer?.invalidate()
    }
    
    @IBAction func pickerBtnAction(_ sender: Any) {
        pickerView.isHidden = false
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
                this.APItimer = Timer.scheduledTimer(timeInterval: 60, target: this, selector: #selector(this.getDeviceDetailsWithOutActivityInd), userInfo: nil, repeats: true)
                print("")
            case .failure(let error):
                statusBarMessage(.CustomError, error)
                printLog(error)
            }
        }
    }
    
    @objc   func getDeviceDetailsWithOutActivityInd()  {
        vehicleFlowViewModel.getDeviceData(serialNO: serialNumber) {(_) in}}
    
    deinit {
        
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
    
    func reloadData() {
        tableViewOutlet.invalidateIntrinsicContentSize()
        tableViewOutlet.reloadData()
    }
    
    func loadData(vm: [TripDetailsModel], maxSpd: Double, minSpd: Double, distance: Double) {
        tableViewOutlet.reloadData()
        minSpdLbl.text = String(minSpd.truncate(places: 2)) + " km/hr"
        maxSpdLbl.text = String(maxSpd.truncate(places: 2)) + " km/hr"
        totalDistLbl.text = String(distance.truncate(places: 2)) + " km"
    }
}
