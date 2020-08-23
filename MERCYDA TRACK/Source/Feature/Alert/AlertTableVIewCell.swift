//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit

class AlertTableVIewCell: UITableViewCell {
    
    @IBOutlet weak var vehicleNumberLabel: UILabel!
    @IBOutlet weak var vehicleType: UIImageView!
    @IBOutlet weak var alertDispalayView: UIView!
    @IBOutlet weak var alertCountLabel: UILabel!
    @IBOutlet weak var mainpowerOffView: UIView!
    @IBOutlet weak var wireCutAlertView: UIView!
    @IBOutlet weak var emergencyAlertView: UIView!
    @IBOutlet weak var overspeedAlertView: UIView!
    
    @IBOutlet weak var mainPowerAlertlabel: UILabel!
    @IBOutlet weak var wirecutAlertLabel: UILabel!
    @IBOutlet weak var emergencyAlertLabel: UILabel!
    @IBOutlet weak var overspeedAlertLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        alertDispalayView.layer.cornerRadius = alertDispalayView.frame.height/2
        alertDispalayView.clipsToBounds = true
    }
    
    func setAlertdatas(vehicleObject:Vehicle){
        self.vehicleNumberLabel.text = vehicleObject.vehicle_registration
        getVehicleType(type:vehicleObject.vehicle_type!)
        if let alertCOunt = vehicleObject.alert_count{
            alertCountLabel.text = "\(alertCOunt)"
        }
        
        //mainpowerOffView.isHidden = true
        
        if let mainpowerRemoval = vehicleObject.main_power_removal_alert_count{
            
            mainpowerOffView.isHidden = mainpowerRemoval == 0
            mainPowerAlertlabel.text = "\(mainpowerRemoval)"
        }
        
        if let wirecutAlert = vehicleObject.wire_cut_alert_count{
            wireCutAlertView.isHidden = wirecutAlert == 0
            wirecutAlertLabel.text = "\(wirecutAlert)"
            
        }
        
        if let emergencyAlert = vehicleObject.emergency_alert_count{
            emergencyAlertView.isHidden = emergencyAlert == 0
            emergencyAlertLabel.text = "\(emergencyAlert)"
        }
        
        
        if let overspeed = vehicleObject.emergency_alert_count{
            
            overspeedAlertView.isHidden = overspeed == 0
            printLog(overspeed)
            overspeedAlertLabel.text = "\(overspeed)"
        }
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
        
    }
    
    
    func getVehicleType(type:String){
        switch type{
        case VehicleModel.Lorry.rawValue:
            self.vehicleType.image = UIImage.init(named:"Lorry")
        case VehicleModel.MiniTruck.rawValue:
            self.vehicleType.image = UIImage.init(named: "minilorry")
        case VehicleModel.Car.rawValue:
            self.vehicleType.image = UIImage.init(named: "car")
        default:
            self.vehicleType.image = UIImage.init(named:"Lorry")
        }
    }
}
