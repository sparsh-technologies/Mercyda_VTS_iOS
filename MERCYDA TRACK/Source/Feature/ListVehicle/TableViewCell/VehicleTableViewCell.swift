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
        printLog(vehicle.createdTime!)
        switch vehicle.vehicle_type {
        case VehicleModel.Lorry.rawValue:
        self.vehicleImage.image = UIImage.init(named:"Lorry")
        case VehicleModel.MiniTruck.rawValue:
        self.vehicleImage.image = UIImage.init(named: "minilorry")
        case VehicleModel.Car.rawValue:
        self.vehicleImage.image = UIImage.init(named: "car")
        default:
        self.vehicleImage.image = UIImage.init(named:"Lorry")
        }
        self.adressLabel.text = vehicle.address
        
        switch vehicle.last_updated_data?.vehicle_mode {
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
    
}
