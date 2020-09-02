//
//  VehicleTableViewCell.swift
//  MERCYDA TRACK
//
//  Created by Tony on 07/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    /// MARK: - Properties
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var vehicleImageContainerView: UIView!
    @IBOutlet weak var vehicleNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var ignitionImageView: UIImageView!
    
    @IBOutlet weak var statusImgeView: UIImageView!
    let networknetworkServiceCalls = NetworkServiceCalls()
    @IBOutlet weak var signalImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override  func layoutSubviews() {
        vehicleImageContainerView.roundCorners(.allCorners, radius: 10)
    }
    
    
    
    /// Function for setting data in vehicle list tableviewcell
    /// - Parameter vehicle:Vehicle objcet
    func setVehicleData(vehicle:Vehicle){
        
        self.vehicleNumberLabel.text = vehicle.vehicle_registration
        self.selectionStyle = .none
        self.timeLabel.text = Utility.getDate(unixdateinMilliSeconds:vehicle.last_updated_data?.source_date ?? 0)
        self.adressLabel.text = vehicle.address2
        if let signalStrength = vehicle.last_updated_data?.gsm_signal_strength{
            setSignalStrength(signalStrength: signalStrength)
        }
        
        if let speed =  vehicle.last_updated_data?.speed{
            if speed > 0{
                speedLabel.text = "\(speed)"
            }
            else{
                speedLabel.text = ""
            }
        }
        if let activeStatus = vehicle.last_updated_data?.valid_status{
            if activeStatus{
                statusImgeView.image = UIImage.init(named:"dishActive")
            }
            else{
                statusImgeView.image = UIImage.init(named:"dishInactive")
            }
        }
        
        getVehicleType(type:vehicle.vehicle_type!)
        //  self.getLoc(corinates:(lat: (vehicle.last_updated_data?.latitude?.toDouble())!, lon:(vehicle.last_updated_data?.longitude?.toDouble())!))
        if let igngitionStatus = vehicle.last_updated_data?.ignition{
            setIgnition(status:igngitionStatus)
        }
       
        if type == "Moving"{
            self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
           }
           else if type == "Sleep"{
           self.vehicleImageContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
           }
        else if type == "Idle"{
             self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        }
        else if type == "Dashboard"{
//            if let vehicleMode = vehicle.last_updated_data?.vehicle_mode {
//                       setVehicleMode(mode:vehicleMode)
//                   }
            if let vehicleMode = vehicle.type{
                                  setVehicleMode(mode:vehicleMode)
                              }
        }
        else if type == "Online"{
             if let vehicleMode = vehicle.last_updated_data?.vehicle_mode {
                                setVehicleMode(mode:vehicleMode)
                            }
        }
            
        else if type == "Offline"{
            self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.red, secondColor:UIColor.red)
        }
    }
    
    
    /// function for signal strengtf
    /// - Parameter signalStrength:SignalStength
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
    
    /// Function for setting vehicle type
    /// - Parameter type:vehicleType
    func getVehicleType(type:String){
        switch type{
        case VehicleModel.Lorry.rawValue:
            self.vehicleImage.image = UIImage.init(named:"Lorry")
        case VehicleModel.MiniTruck.rawValue:
            self.vehicleImage.image = UIImage.init(named: "minilorry")
        case VehicleModel.Car.rawValue:
            self.vehicleImage.image = UIImage.init(named: "car")
        default:
            self.vehicleImage.image = UIImage.init(named:"Lorry")
        }
    }
    
    
    /// Function for setting Ignition Status
    /// - Parameter status: ignitionstatus
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
    
    /// Function for setting vehicle mode
    /// - Parameter mode: vehiclemode
    
   
    
    func setVehicleMode(mode:String){
    
            
        
       
        switch mode{
        case VehicleMode.Moving.rawValue:
            printLog("Moving xxxxxxxx")
        //    self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
             self.vehicleImageContainerView.backgroundColor = Utility.hexStringToUIColor("#179b17")
        case VehicleMode.Sleep.rawValue:
         //   self.vehicleImageContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
              self.vehicleImageContainerView.backgroundColor =  Utility.hexStringToUIColor("#dea51e")
        case VehicleMode.Idle.rawValue:
            //self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
             self.vehicleImageContainerView.backgroundColor = Utility.hexStringToUIColor("#4252D9")
        case VehicleMode.Offline.rawValue:
            self.vehicleImageContainerView.backgroundColor = UIColor.red
        default:
              printLog("nothing")
        }
//
//        if mode == "S"{
//        self.vehicleImageContainerView.backgroundColor =  Utility.hexStringToUIColor("#dea51e")
//        }
//        else if mode == "M"{
//        //self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
//        self.vehicleImageContainerView.backgroundColor = Utility.hexStringToUIColor("#179b17")
//        }
//        else if mode == "H"{
//        self.vehicleImageContainerView.backgroundColor = Utility.hexStringToUIColor("#4252D9")
//        }
        
    }
    
    
   
    
}

extension String {
    
    /// Function for converting String to Double
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
