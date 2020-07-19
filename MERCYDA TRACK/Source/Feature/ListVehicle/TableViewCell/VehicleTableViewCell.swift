//
//  VehicleTableViewCell.swift
//  MERCYDA TRACK
//
//  Created by Tony on 07/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {

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
    
   
    
    func setVehicleData(vehicle:Vehicle){
       
        self.vehicleNumberLabel.text = vehicle.vehicle_registration
        self.selectionStyle = .none
        self.timeLabel.text = Utility.getDate(unixdateinMilliSeconds:vehicle.modifiedTime!)
        self.adressLabel.text = vehicle.address2
        if let signalStrength = vehicle.last_updated_data?.gsm_signal_strength{
          setSignalStrength(signalStrength: signalStrength)
        }
        
        if let speed =  vehicle.last_updated_data?.speed{
            if speed > 0{
                speedLabel.text = "\(speed)"
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
        if let vehicleMode = vehicle.last_updated_data?.vehicle_mode {
            setVehicleMode(mode:vehicleMode)
        }
    }
    
    
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
    
    func setVehicleMode(mode:String){
       switch mode{
        case VehicleMode.Moving.rawValue:
            self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
        case VehicleMode.Sleep.rawValue:
            self.vehicleImageContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        case VehicleMode.Idle.rawValue:
            self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        default:
            self.vehicleImageContainerView.addGradientBackground(firstColor:UIColor.green, secondColor: UIColor.black)
        }
    }
    
    
   
    func getLocationDetails(locationCoordinates: Latlon, block: @escaping (_ cityAddress: String) -> Void) {
          //dispatchTask?.cancel()
          self.networknetworkServiceCalls.getLocationDetails(locationCoordinates: locationCoordinates) { (result) in
                  switch result {
                  case .success(response: let response as LocationDetailsResponse):
                      block("\(response.display_name ?? "")")
                  default:
                      printLog("api failure")
                      block("")
                  }
              }
          }
   
}
   
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
