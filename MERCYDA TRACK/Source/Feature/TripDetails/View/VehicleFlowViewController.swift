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
    func loadData(vm: [TripDetailsModel], maxSpd: Double, minSpd: String, distance: Double, mode: String, lastLocationName: String)
    func reloadData()
    func updateVehicleDetails(lastKnownPlace: String)
}

final class VehicleFlowViewController: BaseViewController {
    
    @IBOutlet weak var rigthBtnOutlet: UIBarButtonItem!
    @IBOutlet weak var leftBarBtnOutlet: UIBarButtonItem!
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
    weak var APItimer: Timer?
    var flagForDateTitle = true
    @IBOutlet weak var vehicleImageview: UIImageView!
    @IBOutlet weak var vehicleNumber: UILabel!
    @IBOutlet weak var signalImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var ignitionImageView: UIImageView!
    @IBOutlet weak var isActiveImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    
    private var totalDistance: Double?
    private var maximumSpeed: Double?
    var isDeviceListCalled = 0
    let rightBarButton = UIButton()
    var curentDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleFlowViewModel = VehicleFlow()
        // Do any additional setup after loading the view.
        serialNumber = vehicleObj?.last_updated_data?.serial_no ?? ""
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        vehicleFlowViewModel?.delegate = self
        tableViewOutlet.register(UINib(nibName: "VehicleDataFlowTableViewCell", bundle: nil), forCellReuseIdentifier: CellID.VehicleDataFlowCell.rawValue)
        getDeviceDetails()
        isDeviceListCalled = 1
        // vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        showDatePicker()
        setuiDatas()
        self.navigationItem.leftItemsSupplementBackButton = true
//        self.rightBarButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
//        self.rightBarButton.setImage(UIImage.init(named:"right"), for: .normal)
//        let one =  rightBarButton.leadingAnchor.constraint(equalTo:pickerBtn.leadingAnchor, constant: 20)
//        rightBarButton.centerYAnchor.constraint(equalTo: pickerBtn.centerYAnchor).isActive = true
//         NSLayoutConstraint.activate([one])
//        self.navigationController?.navigationBar.addSubview(rightBarButton)
        curentDate = Utility.getCurrentDate()

    }
    @objc func buttonClick(){
      
    }
    
    override func viewDidLayoutSubviews() {
//        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"right.png"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(buttonClick))
//                    rightBarButtonItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 80)
//
//                    self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)

        
        
//         let suggestImage  = UIImage(named: "right.png")!
//         let suggestButton = UIButton(frame: CGRect(x:0, y:0, width:20, height:20))
//         suggestButton.setBackgroundImage(suggestImage, for: .normal)
//        // suggestButton.addTarget(self, action: #selector(self.showPopover(sender:)), for:.touchUpInside)
//         //suggestButton.transform = CGAffineTransform(translationX: 0, y: -8)
//         // add the button to a container, otherwise the transform will be ignored
//         let suggestButtonContainer = UIView(frame: suggestButton.frame)
//         suggestButtonContainer.addSubview(suggestButton)
//         let suggestButtonItem = UIBarButtonItem(customView: suggestButtonContainer)
//         // add button shift to the side
//         navigationItem.rightBarButtonItem = suggestButtonItem
        

           
           
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if vehicleFlowViewModel == nil {
            vehicleFlowViewModel = VehicleFlow()
        }
        if isDeviceListCalled != 1 {
            getDeviceDetailsWithOutActivityInd()
        }
        APItimer = Timer.scheduledTimer(timeInterval: 24, target: self, selector: #selector(getDeviceDetailsWithOutActivityInd), userInfo: nil, repeats: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        vehicleContainerView.roundCorners(.allCorners, radius: 15)
        if flagForDateTitle {
            pickerBtn.setTitle(vehicleFlowViewModel?.titleDateForNavBtn(date: Date()), for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isDeviceListCalled = 0
        APItimer?.invalidate()
        APItimer = nil
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
        
        getVehicleType(type:(vehicleObj?.vehicle_type!)!)
        
        
        //        if let vehicleMode = vehicleObj?.last_updated_data?.vehicle_mode {
        //            setVehicleMode(mode:vehicleMode)
        //        }
        if type == "Moving"{
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
        }
        else if type == "Sleep"{
            self.vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        }
        else if type == "Idle"{
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        }
        else if type == "Dashboard"{
            //            if let vehicleMode = vehicleObj?.last_updated_data?.vehicle_mode {
            //                setVehicleMode(mode:vehicleMode)
            //
            //            }
            if let vehicleMode = vehicleObj?.type{
                setVehicleMode(mode:vehicleMode)
            }
        }
        else if type == "Online"{
            if let vehicleMode =  vehicleObj?.last_updated_data?.vehicle_mode {
                setVehicleMode(mode:vehicleMode)
            }
        }
            
        else if type == "Offline"{
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.red, secondColor:UIColor.red)
        }
        
    }
    
    
    
    
    @IBAction func pickerBtnAction(_ sender: Any) {
        pickerView.isHidden = false
    }
    
    @IBAction func onClickMapButton(_ sender: Any) {
        self.goToMaps()
    }
    
    func getDeviceDetails()  {
      
        mapButton.isHidden = true
        MBProgressHUD.showAdded(to: view, animated: true)
        vehicleFlowViewModel?.getDeviceData(serialNO: serialNumber) { [weak self] (result) in
            guard let this = self else {
                return
            }
            MBProgressHUD.hide(for: this.view, animated: false)
            switch result {
            case .success(_):
//                this.APItimer = Timer.scheduledTimer(timeInterval: 30, target: this, selector: #selector(this.getDeviceDetailsWithOutActivityInd), userInfo: nil, repeats: true)
                this.mapButton.isHidden = false
                print("")
            case .failure(let error):
                statusBarMessage(.CustomError, error)
                printLog(error)
            }
        }
    }
    
    @objc func getDeviceDetailsWithOutActivityInd()  {
        
        vehicleFlowViewModel?.getDeviceDataForBackgroundUpdate(serialNO: serialNumber) { [weak self] (result) in
            guard let this = self else {
                return
            }
            switch result {
            case .success(_):
                this.mapButton.isHidden = false
            case .failure(_):
                this.mapButton.isHidden = true
            }
        }
    }
    
    deinit {
        self.vehicleFlowViewModel?.dispatcher = nil
        self.vehicleFlowViewModel?.dispatchGroup = nil
        self.vehicleFlowViewModel = nil
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
        else if  (signalStrength >= 30 && signalStrength <= 64) {
            signalImageView.image = UIImage.init(named: "range50")
        }
        else if  (signalStrength >= 5 && signalStrength <= 29) {
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
        //        switch mode{
        //        case VehicleMode.Moving.rawValue:
        //            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
        //        case VehicleMode.Sleep.rawValue:
        //            self.vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        //        case VehicleMode.Idle.rawValue:
        //            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        //        default:
        //            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green, secondColor: UIColor.black)
        //        }
        
        switch mode{
        case VehicleMode.Moving.rawValue:
            printLog("Moving xxxxxxxx")
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
        // self.vehicleContainerView.backgroundColor = Utility.hexStringToUIColor("#179b17")
        case VehicleMode.Sleep.rawValue:
            self.vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        //   self.vehicleContainerView.backgroundColor =  Utility.hexStringToUIColor("#dea51e")
        case VehicleMode.Idle.rawValue:
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        //self.vehicleContainerView.backgroundColor = Utility.hexStringToUIColor("#4252D9")
        case VehicleMode.Offline.rawValue:
            self.vehicleContainerView.backgroundColor = UIColor.red
        default:
            printLog("nothing")
        }
    }
    
    
}

extension VehicleFlowViewController: VehicleFlowControllerDelegate {
    
    func updateVehicleDetails(lastKnownPlace: String) {
        if addressLabel.text == "" || addressLabel.text == nil {
            addressLabel.text = lastKnownPlace
            vehicleObj?.address2 = lastKnownPlace
        }
    }
    
    func reloadData() {
        tableViewOutlet.invalidateIntrinsicContentSize()
        tableViewOutlet.reloadData()
    }
    
    func loadData(vm: [TripDetailsModel], maxSpd: Double, minSpd: String, distance: Double, mode: String, lastLocationName: String) {
        tableViewOutlet.reloadData()
        minSpdLbl.text = minSpd + " km/hr"
        maxSpdLbl.text = String(maxSpd.truncate(places: 2)) + " km/hr"
        totalDistLbl.text = String(distance.truncate(places: 2)) + " km"
        self.totalDistance = distance
        self.maximumSpeed = maxSpd
        
        //        if mode == "M" {
        //            vehicleContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
        //        }
        //        if mode == "H" {
        //            vehicleContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        //        }
        //        if mode == "S" {
        //            vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        //        }
    }
    
    func goToMaps() {
        let storyboard = UIStoryboard(name: "Maps", bundle: nil)
        guard let mapVC = storyboard.instantiateViewController(withIdentifier: "MapVC") as? MapVC
            else { return }
        let parkingSlots = vehicleFlowViewModel?.parkingLocationForMap()
        let viewModel = MapVCViewModel.init(deviceList: vehicleFlowViewModel?.activePacketList, serialNumber: serialNumber, parkingLocations: parkingSlots, totalDistance : self.totalDistance ?? 0.00, maximumSpeed: self.maximumSpeed ?? 0.00)
        
        mapVC.viewModel = viewModel
        mapVC.vehicleObject = vehicleObj
        mapVC.isToday = vehicleFlowViewModel?.isToday() ?? false
        self.show(mapVC, sender: self)
    }
    
    
}

