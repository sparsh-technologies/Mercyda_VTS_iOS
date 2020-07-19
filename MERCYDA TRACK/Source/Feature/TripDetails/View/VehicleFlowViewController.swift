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
    var vehicleFlowViewModel : VehicleFlow?
    var serialNumber = String()
    var vehicleObj:Vehicle?
    var APItimer: Timer?
    var flagForDateTitle = true
    @IBOutlet weak var vehicleImageview: UIImageView!
    @IBOutlet weak var vehicleNumber: UILabel!
    @IBOutlet weak var signalImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var ignitionImageView: UIImageView!
    @IBOutlet weak var isActiveImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleFlowViewModel = VehicleFlow()
        // Do any additional setup after loading the view.
        serialNumber = vehicleObj?.last_updated_data?.serial_no ?? ""
        self.navigationController?.navigationBar.isHidden = false
        vehicleFlowViewModel?.delegate = self
        tableViewOutlet.register(UINib(nibName: "VehicleDataFlowTableViewCell", bundle: nil), forCellReuseIdentifier: CellID.VehicleDataFlowCell.rawValue)
        getDeviceDetails()
       // vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        showDatePicker()
        setuiDatas()
        
    }
    
    override func viewWillLayoutSubviews() {
        vehicleContainerView.roundCorners(.allCorners, radius: 15)
        if flagForDateTitle {
            pickerBtn.titleLabel?.text = vehicleFlowViewModel?.titleDateForNavBtn(date: Date())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        APItimer?.invalidate()
        APItimer = nil
        self.vehicleFlowViewModel?.dispatcher = nil
        self.vehicleFlowViewModel?.dispatchGroup = nil
        self.vehicleFlowViewModel = nil
        
    }
    
    func setuiDatas(){
        self.vehicleNumber.text = vehicleObj?.vehicle_registration
        self.addressLabel.text = vehicleObj?.address2
        if let speed =  vehicleObj?.last_updated_data?.speed{
            if speed > 0{
                speedLabel.text = "\(speed)"
                
            }
        }
        if let signalStrength = vehicleObj?.last_updated_data?.gsm_signal_strength{
                 setSignalStrength(signalStrength: signalStrength)
            
        }
        
        if let activeStatus = vehicleObj?.last_updated_data?.valid_status{
            if activeStatus{
                isActiveImageView.image = UIImage.init(named:"dishActive")
            }
            else{
                isActiveImageView.image = UIImage.init(named:"dishInactive")
            }
        }
        
        if let igngitionStatus = vehicleObj?.last_updated_data?.ignition{
        setIgnition(status:igngitionStatus)
        }
        if let vehicleMode = vehicleObj?.last_updated_data?.vehicle_mode {
                   setVehicleMode(mode:vehicleMode)
               }
        getVehicleType(type:(vehicleObj?.vehicle_type!)!)
        if let vehicleMode = vehicleObj?.last_updated_data?.vehicle_mode {
                   setVehicleMode(mode:vehicleMode)
               }
    }
    
    
    
    
    @IBAction func pickerBtnAction(_ sender: Any) {
        pickerView.isHidden = false
    }
    
    func getDeviceDetails()  {
        MBProgressHUD.showAdded(to: view, animated: true)
        vehicleFlowViewModel?.getDeviceData(serialNO: serialNumber) { [weak self] (result) in
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
        vehicleFlowViewModel?.getDeviceData(serialNO: serialNumber) {(_) in}}
    
    deinit {
        printLog("ViewController Released from memory : VehicleFlowViewController")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func setSignalStrength(signalStrength:Int){
        if signalStrength > 80 {
            signalImageView.image = UIImage.init(named: "fullrange")
        }
        else if (signalStrength >= 65 && signalStrength <= 79) {
            signalImageView.image = UIImage.init(named: "range75")
        }
        else if  (signalStrength >= 35 && signalStrength <= 64) {
            signalImageView.image = UIImage.init(named: "range50")
        }
       else if  (signalStrength >= 5 && signalStrength <= 34) {
           signalImageView.image = UIImage.init(named: "range25")
       }
        else{
             signalImageView.image = UIImage.init(named: "rangeInactive")
        }
    }
    func setIgnition(status:String){
           switch status {
           case IgnitionType.ON.rawValue:
               ignitionImageView.image = UIImage.init(named:"ignition")
           case IgnitionType.OFF.rawValue:
               ignitionImageView.image = UIImage.init(named:"ignitionoff")
           default:
                ignitionImageView.image = UIImage.init(named:"ignition")
           }
       }
    
    func getVehicleType(type:String){
        switch type{
        case VehicleModel.Lorry.rawValue:
        self.vehicleImageview.image = UIImage.init(named:"Lorry")
        case VehicleModel.MiniTruck.rawValue:
        self.vehicleImageview.image = UIImage.init(named: "minilorry")
        case VehicleModel.Car.rawValue:
        self.vehicleImageview.image = UIImage.init(named: "car")
        default:
        self.vehicleImageview.image = UIImage.init(named:"Lorry")
        }
    }
    
    func setVehicleMode(mode:String){
          switch mode{
           case VehicleMode.Moving.rawValue:
               self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
           case VehicleMode.Sleep.rawValue:
               self.vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
           case VehicleMode.Idle.rawValue:
               self.vehicleContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
           default:
               self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green, secondColor: UIColor.black)
           }
       }
    
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
  
